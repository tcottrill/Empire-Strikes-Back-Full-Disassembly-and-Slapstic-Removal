"""Defines generator: esb_defines.asm and esb_sound_defines.asm.

Every alias the listings use is here (emit.py records them in
build/used_*.json), each with a description:

  upper case   Atari's comment on the definition in the Star Wars source, for a
               symbol carried over from there (where the Star Wars defines file
               has a lower-case description, that one is kept, in lower case)
  lower case   written for this disassembly (define_docs.py and hints.py)

Returns the number of define_docs notes that no alias uses.
"""
import collections, json, os, sys
import paths, slapstic, image

try:
    import define_docs
except ImportError:
    define_docs = None
try:
    import hints
except ImportError:
    hints = None

MAIN_MAP = [
    ("VectorRam", 0x0000, "Through $2FFF. AVG display lists."),
    ("VectorRom", 0x3000, "Through $3FFF (esb_vector_rom.asm)."),
    ("InputPorts", 0x4300, "Through $439F. Switch inputs $4300 and $4320, option switches $4340 and $4360, ADC $4380."),
    ("SoundLatch", 0x4400, "$4400 data to and from the sound CPU, $4401 the two ready flags."),
    ("NvRam", 0x4500, "Through $45FF. Non-volatile RAM: high scores and bookkeeping."),
    ("OutputLatches", 0x4600, "Through $46FF. VG go $4600, VG reset $4620, watchdog $4640, IRQ clear $4660, output bits $4680, NVRAM store $46A0, ADC channel $46C0, sound reset $46E0."),
    ("MathBox", 0x4700, "Through $4707. Matrix processor start and block index, divider; reads give the quotient and the random number."),
    ("CpuRam", 0x4800, "Through $4FFF. Program RAM; the direct page is here and the stack grows down from the top."),
    ("MathRam", 0x5000, "Through $5FFF. Matrix processor RAM, shared with the CPU."),
    ("BankedRomLow", 0x6000, "Through $7FFF. Bank 0 (esb_bank0_rom.asm) or bank 1 (esb_bank1_rom.asm), by W_BANK D7."),
    ("SlapsticWindow", 0x8000, "Through $9FFF. One of four pages, selected by the slapstic (esb_slapstic0_rom.asm .. 3)."),
    ("BankedRomHigh", 0xA000, "Through $FFFF. Switched with $6000-$7FFF by W_BANK D7; each bank has its own 6809 vectors at $FFF2."),
]
SOUND_MAP = [
    ("SoundOut", 0x0000, "Through $07FF, write: byte to the main CPU."),
    ("SoundIn", 0x0800, "Through $0FFF, read: byte from the main CPU."),
    ("RiotRam", 0x1000, "Through $107F. 6532 RAM: the direct page and the stack."),
    ("RiotIo", 0x1080, "Through $109F. 6532 ports and timer."),
    ("Pokeys", 0x1800, "Through $183F. Four POKEYs, registers interleaved."),
    ("SoundRam", 0x2000, "Through $27FF. Program RAM."),
    ("SoundRomLow", 0x4000, "Through $7FFF (esb_sound_rom.asm)."),
    ("SoundRomHigh", 0xC000, "Through $FFFF (esb_sound_rom.asm); the 6809 vectors are at $FFF2."),
]

def section_of(cpu, v, sw_section):
    if sw_section == "Constants" or sw_section.startswith("Constants"):
        return "Constants"
    if cpu == "main":
        if 0x4300 <= v < 0x4800:
            return "Hardware registers"
        if 0x4800 <= v < 0x5000:
            return "CPU RAM"
        if 0x5000 <= v < 0x6000:
            return "Math RAM"
        if v < 0x3000 and sw_section in ("CPU RAM", "Math RAM", "Hardware registers", "Vector RAM"):
            return "Vector RAM"
    else:
        if v < 0x1000 and sw_section not in ("Constants",):
            return "Hardware registers"
        if 0x1000 <= v < 0x1080:
            return "6532 RAM"
        if 0x1080 <= v < 0x2000:
            return "Hardware registers"
        if 0x2000 <= v < 0x2800:
            return "Program RAM"
    return "Constants"

def write(cpu, fname, title, mem_map):
    used = json.load(open(paths.build("used_%s.json" % cpu)))
    carry = json.load(open(os.path.join(paths.HERE, "sw_carry.json")))
    swdef = carry["sw_defines"][cpu]
    notes = dict(getattr(define_docs, cpu.upper(), {})) if define_docs else {}
    ram_hints = getattr(hints, "RAM", {}).get(cpu, {}) if hints else {}
    hint_desc = {nm: d for a, (nm, d) in ram_hints.items()}
    for start, end, nm, desc in (getattr(hints, "RAM_BLOCKS", {}).get(cpu, []) if hints else []):
        hint_desc[nm] = "Through $%04X. %s" % (end - 1, desc)
    sections = collections.OrderedDict((s, []) for s in (
        "Hardware registers", "Vector RAM", "CPU RAM", "Math RAM", "6532 RAM", "Program RAM",
        "Slapstic", "Constants"))
    seen_notes = set()
    undescribed = 0
    for nm, v in used["used"].items():
        origin = used["origin"][nm][1]
        swv, swsec, swcm = swdef.get(nm, ("", "", ""))
        if origin in ("maze", "slapstic"):
            sec = "Slapstic"
            if nm.startswith("MZ_"):
                e = slap_maze[v]
                desc = "maze entry: calls P%d_%04X on page %d and %s" % (
                    e["page"], e["target"], e["page"],
                    "restores the caller's page" if e["restores"] else
                    "leaves page %d selected (the routine runs the slapstic's alternate sequence)" % e["leaves"])
            elif nm == "SLAP_ARM":
                desc = "stub BITA $8000 / RTS: the read of $8000 arms the slapstic"
            else:
                desc = "stub: a jump here selects page %s (if the slapstic is armed), arms it again and returns" % nm[-1]
        else:
            sec = section_of(cpu, v, swsec)
            if nm in notes:
                desc = notes[nm]
                seen_notes.add(nm)
            elif nm in hint_desc:
                desc = hint_desc[nm]
            else:
                desc = swcm
            rn = getattr(hints, "RAM_NOTES", {}).get(cpu, {}).get(nm) if hints else None
            if rn:
                desc = (desc.rstrip() + ("" if not desc or desc.rstrip().endswith(".") else ".") + " In ESB: " + rn).strip()
            if not desc:
                undescribed += 1
        sections[sec].append((v, nm, desc))
    out = [title, ""]
    out.append(";----------------------------------[ Memory map ]----------------------------------")
    for nm, v, d in mem_map:
        out.append("%-24s $%02X%s;%s" % (".alias " + nm, v, " " * max(1, 9 - len("$%02X" % v)), d))
    for sec, items in sections.items():
        if not items:
            continue
        out.append("")
        out.append(";----------------------------------[ %s ]----------------------------------" % sec)
        key = (lambda t: (t[0], t[1])) if sec != "Constants" else (lambda t: (t[1],))
        for v, nm, desc in sorted(items, key=key):
            vs = "$%02X" % v
            out.append("%-24s %s%s%s" % (".alias " + nm, vs, " " * max(1, 9 - len(vs)), ";" + desc if desc else ""))
    with open(os.path.join(paths.HERE, fname), "w", newline="\n") as f:
        f.write("\n".join(out).rstrip() + "\n")
    stale = sorted(set(notes) - seen_notes)
    print("  %-24s %4d aliases, %d without a description%s" % (
        fname, sum(len(i) for i in sections.values()), undescribed,
        ", %d unused notes: %s" % (len(stale), " ".join(stale[:8])) if stale else ""))
    return len(stale)

HEAD_MAIN = """;The Empire Strikes Back (Atari, 1985) - hardware map, RAM variables and equates
;of the main 6809, for esb_bank0_rom.asm, esb_bank1_rom.asm, the four
;esb_slapstic*_rom.asm and esb_vector_rom.asm.
;Names carried over from the Star Wars source are Atari's identifiers ('.' -> '_'
;and '$' -> 'S_'), given to the address or value the same code uses here.
;Descriptions in upper case are Atari's comments on the Star Wars definitions;
;those in lower case were written for the Star Wars or for this disassembly.
;Generated by disasm/emit_defines.py; every symbol the listings use is here."""
HEAD_SOUND = """;The Empire Strikes Back (Atari, 1985) - hardware map, RAM variables and equates
;of the sound board's 6809, for esb_sound_rom.asm.
;Names carried over from the Star Wars source are Atari's identifiers ('.' -> '_'
;and '$' -> 'S_'), given to the address or value the same code uses here.
;Descriptions in upper case are Atari's comments on the Star Wars definitions;
;those in lower case were written for the Star Wars or for this disassembly.
;Generated by disasm/emit_defines.py; every symbol the listings use is here."""

slap_maze = {}

def main():
    global slap_maze
    slap_maze = slapstic.maze_entries(image.load("esb_slapstic.bin"))
    n = write("main", "esb_defines.asm", HEAD_MAIN, MAIN_MAP)
    n += write("sound", "esb_sound_defines.asm", HEAD_SOUND, SOUND_MAP)
    return n

if __name__ == "__main__":
    sys.exit(1 if main() else 0)
