"""Hand-kept knowledge the tracer and the listing generator cannot derive.

Addresses are (space, address); spaces are B0, B1 (the two banks), P0..P3 (the
slapstic pages), V (vector ROM), S (sound CPU).
"""

# --- tracer -----------------------------------------------------------------
ENTRIES_MAIN = [            # (bank, page or None, address): code nothing visibly calls
    (0, None, 0x6623),      # an unreachable BRA, as in Star Wars
    (0, None, 0xB2FC),      # the 7-, 6- and 5-bit entries of the logical shift right family
    (0, None, 0xB69E), (0, None, 0xB6A3), (0, None, 0xB6A8), (0, None, 0xB6AD),   # four score routines nothing calls
    (0, None, 0xF56F),      # self test: the checker board state, reached through the state table word at $F39F
    (0, None, 0xF9D2),      # self test: the walking-bit matrix test, reached through the table word at $F7E6
    (1, None, 0x621B),      # bank 1 library: the ASRD7 entry (nothing calls it)
    (1, None, 0x6275),      # bank 1 library: the LSLD7 .. LSLD3 entries (nothing calls them)
    (1, None, 0xDA38), (1, None, 0xDA3F), (1, None, 0xDA5D), (1, None, 0xDA7B), (1, None, 0xDA9D),
    (1, None, 0xDAA5),      # six threaded draw primitives that nothing runs
    (0, 1, 0x90CF),         # LDX #$4928 falling into gun_find_free: an entry nothing calls
    (1, None, 0xFFC0),      # the ROM test's sum of a ROM's bank 1 half: bank 0 sets W_BANK at $FFBD and the
                            # next instruction is fetched here (found by emu_src/tests/coverage.py)
    # stale image the orphan pass read from the wrong byte: where the first whole instruction is
    (0, 0, 0x9474), (0, 1, 0x952C), (0, 0, 0x952C), (0, 2, 0x952C), (0, 3, 0x952C),
]
ENTRIES_SOUND = [0xFC6A]    # LDY #table / JMP AUDNEW: an effect start with no entry in the command table
TABLES_MAIN = []            # (bank, page or None, base, count): tables of code addresses
TABLES_SOUND = []           # (base, count)
TABLES = {}                 # (space, address of the indirect JSR/JMP): (base, count)
NOT_CODE = {                # (space, address): looks like code to the orphan pass, is not
    ("P0", 0x9472), ("P0", 0x9473), ("P0", 0x952B), ("P1", 0x952B), ("P2", 0x952B), ("P3", 0x952B),
}
# Stale image from earlier builds that nothing reaches (found by the annotators,
# docs/SLAPSTIC.md).  A Star Wars name found both here and in live code belongs
# to the live copy; the copy here gets the page suffix.
DEAD_RANGES = [
    ("P0", 0x9472, 0x9561), ("P0", 0x9958, 0x9C1A), ("P0", 0x9CA7, 0xA000),
    ("P1", 0x952B, 0x9561), ("P1", 0x9DCD, 0xA000),
    ("P2", 0x934B, 0x9561), ("P2", 0x9C1A, 0xA000),
    ("P3", 0x9361, 0x9561), ("P3", 0x9D2B, 0xA000),
]
NOT_CODE_RANGES = [         # (space, start, end): data the orphan pass must not try as code
    ("S", 0xC05E, 0xD937),  # the tune data
    ("P1", 0x90E4, 0x9168), # the two enemy fire tables
]
STOP_AFTER = {              # (space, address): flow does not continue after this instruction
    ("B1", 0xFFD5),         # STA W_BANK: back to bank 0, which goes on at $FFD8
}

# --- listings ---------------------------------------------------------------
NAMES = {}                  # (space, address): name            (ours, upper case like Atari's)
HEADERS = {}                # (space, address): description of the routine (lower case = ours)
COMMENTS = {}               # (space, address): comment on the line
REGIONS = [                 # (space, start, end, type[, run address]): data layout; see emit.py
    # the three display-list sets LA35C copies to vector RAM at VGPSROM ($2800)
    ("B0", 0xB97C, 0xBE1C, "avg", 0x2800),
    ("B0", 0xBE1C, 0xC074, "avg", 0x2800),
    ("B0", 0xC074, 0xC4CA, "avg", 0x2800),
    ("B0", 0xB974, 0xB97C, "ptrs"),
]

# --- typed tables (formats.py) ----------------------------------------------
TYPED = [
    ("B0", "msgtab", 0xE7E3, 0xDF),         # VWMESS's table: MESSZ entries
    ("B1", "objtab", 0xD713, 0xD736, 35),   # the 35 3-D objects: point counts, point tables
    ("B1", "words", 0xD77C, 35, 1, lambda i: "object %d" % i if i else None),
    ("B1", "words", 0xD7C2, 35, 1, lambda i: "object %d" % i if i else None),
    ("B1", "words", 0xD808, 35, 1, lambda i: "object %d" % i if i else None),
    ("S", "spktab", 0x4002, 41),            # speech phrases: start and end of each
    ("B1", "outlines", 0x675B, 27),         # the title logo: 27 outlines of move / draw records
    # enemy fire tables: frames to wait, random threshold, address of the highest gun record
    ("P1", "rows", 0x90E4, 17, "bbw", "gun_fire_tab row %d: wait, random threshold, gun record"),
    ("P1", "rows", 0x9128, 16, "bbw", "probot_fire_tab row %d: wait, random threshold, gun record"),
    # keyframe rings of the walker legs: x, y, z offset and frame count; count 0 ends a ring
    ("P0", "rings", [(0x91BE, 2), (0x91CE, 11), (0x921D, 11), (0x926C, 3), (0x9283, 2),
                     (0x9293, 7), (0x92C6, 7), (0x92F9, 7)]),
    # object set-up tables: three position words and four bytes
    ("P0", "rows", 0x8656, 3, "wwwbbbb", "AT-AT set-up row %d: x, y, z, then four bytes"),
    ("P0", "rows", 0x86E7, 3, "wwwbbbb", "AT-AT manual row %d: x, y, z, then four bytes"),
    ("P1", "rows", 0x8633, 6, "wwwbbbb", "AT-ST set-up row %d: x, y, z, then four bytes"),
    ("P1", "rows", 0x86C3, 3, "wwwbbbb", "AT-ST manual row %d: x, y, z, then four bytes"),
    ("P2", "rows", 0x875E, 3, "wwwbbbb", "probot manual row %d: x, y, z, then four bytes"),
    ("P2", "rows", 0x95E6, 12, "wwwbbbb", "asteroid row %d: three words, then four bytes"),
    ("P2", "rows", 0x96C2, 3, "wwwbbbb", "asteroid manual row %d: three words, then four bytes"),
    ("P2", "rows", 0x866C, 6, "bbbb", "probot set-up row %d"),
    ("P0", "rows", 0x8BEB, 12, "bww", "AT-AT leg record %d: a byte and two words"),
    ("P1", "rows", 0x8B6C, 6, "bww", "AT-ST leg record %d: a byte and two words"),
    ("B1", "rows", 0x79EB, 47, "b", None),  # T_DFLT: the NVRAM image defaults, one byte each in ESB
]
SW_DROP_DATA = [("B1", 0x79EB, 0x7A1A)]     # Star Wars statements whose layout does not fit ESB's data

# --- annotations (notes/*.json) ----------------------------------------------
# Names, routine descriptions, line comments and RAM names written for this
# disassembly, one file per stretch of code.  Keys are "SPACE:ADDR" in hex.
#   routines  {"B0:6A12": {"name": "...", "desc": "..."}}
#   labels    {"B0:6842": "name"}                 data tables and inner labels
#   comments  {"B0:6A15": "text"}
#   ram       {"4C47": {"name": "...", "desc": "..."}}       (main or sound CPU, by file)
#   sw_drop_names     ["B0:6671"]     a name carried from Star Wars that is on the wrong routine
#   sw_drop_comments  ["B0:6810"]     a carried comment that does not describe the ESB line
#   sw_drop_symbols   ["GM_WAV"]      a Star Wars symbol given a wrong value here
#   esb_notes  {"B0:70E3": "..."}     what a routine with a Star Wars name does in ESB
#   ram_notes  {"Q_FRC": "..."}       what a variable with a Star Wars name holds in ESB
SW_DROP_NAMES, SW_DROP_COMMENTS, SW_DROP_SYMBOLS = set(), set(), {"main": set(), "sound": set()}
ESB_NOTES, RAM_NOTES = {}, {"main": {}, "sound": {}}
OPERANDS = {}               # "operands": {"B1:74F1": "T_DFLT-$4B"}  the expression an operand really is
NO_HEADER = set()           # "no_header": addresses the tracer made a routine entry of, that are not one
RAM = {"main": {}, "sound": {}}
RAM_BLOCKS = {"main": [], "sound": []}      # (start, end, name, description): name+offset inside
NOTE_PROBLEMS = []

def _load_notes():
    import glob, json, os, re
    here = os.path.dirname(os.path.abspath(__file__))
    good = re.compile(r"^[A-Za-z][A-Za-z0-9_]*$")
    taken = {}
    settled = set()                     # RAM addresses a reconcile file decided
    for path in sorted(glob.glob(os.path.join(here, "notes", "*.json"))):
        base = os.path.basename(path)
        try:
            j = json.load(open(path, encoding="utf-8"))
        except ValueError as e:
            NOTE_PROBLEMS.append("%s: %s" % (base, e))
            continue
        cpu = "sound" if j.get("cpu") == "sound" else "main"

        def key(k):
            sp, a = k.split(":")
            return sp, int(a, 16)

        def claim(nm, what):
            if not good.match(nm):
                NOTE_PROBLEMS.append("%s: bad name %r for %s" % (base, nm, what))
                return False
            if (cpu, nm) in taken and taken[(cpu, nm)] != what:
                NOTE_PROBLEMS.append("%s: name %s for %s is already %s" % (base, nm, what, taken[(cpu, nm)]))
                return False
            taken[(cpu, nm)] = what
            return True

        def clean(t):
            return " ".join(str(t).replace(";", ",").split())

        for k, r in j.get("routines", {}).items():
            if r.get("name") and claim(r["name"], k):
                NAMES.setdefault(key(k), r["name"])
            if r.get("desc"):
                HEADERS.setdefault(key(k), clean(r["desc"]))
        for k, nm in j.get("labels", {}).items():
            if claim(nm, k):
                NAMES.setdefault(key(k), nm)
        for k, t in j.get("comments", {}).items():
            COMMENTS.setdefault(key(k), clean(t))
        for k, r in j.get("ram", {}).items():
            a = int(k, 16)
            if a in RAM[cpu]:
                if RAM[cpu][a][0] != r["name"] and (cpu, a) not in settled:
                    NOTE_PROBLEMS.append("%s: $%04X is %s here, %s earlier" % (base, a, r["name"], RAM[cpu][a][0]))
                continue
            if claim(r["name"], "$%04X" % a):
                RAM[cpu][a] = (r["name"], clean(r.get("desc", "")))
                if "reconcile" in base:
                    settled.add((cpu, a))
        for k in j.get("sw_drop_names", []):
            SW_DROP_NAMES.add(key(k))
        for k, t in j.get("operands", {}).items():
            OPERANDS.setdefault(key(k), str(t).strip())
        for k in j.get("no_header", []):
            NO_HEADER.add(key(k))
        for k in j.get("sw_drop_comments", []):
            SW_DROP_COMMENTS.add(key(k))
        for nm in j.get("sw_drop_symbols", []):
            SW_DROP_SYMBOLS[cpu].add(nm)
        for k, t in j.get("esb_notes", {}).items():
            ESB_NOTES.setdefault(key(k), clean(t))
        for nm, t in j.get("ram_notes", {}).items():
            RAM_NOTES[cpu].setdefault(nm, clean(t))
        for sp, a, e, kind in j.get("regions", []):
            a, e = int(a, 16), int(e, 16)
            if any(r[0] == sp and r[1] < e and a < r[2] for r in REGIONS):
                continue                            # an earlier file already typed these bytes
            REGIONS.append((sp, a, e, kind))
        for b in j.get("ram_blocks", []):
            RAM_BLOCKS[cpu].append((int(b["start"], 16), int(b["end"], 16), b["name"], clean(b.get("desc", ""))))

_load_notes()
