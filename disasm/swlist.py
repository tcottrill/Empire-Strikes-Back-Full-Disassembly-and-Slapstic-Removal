"""Reader for the Star Wars disassembly listings and defines (the published
format: see that project's disasm/README.md).  Used only by swmatch.py.

listing(path) -> list of Line, in file order
defines(path) -> {name: (value, section, comment)}
"""
import re

ADDR = re.compile(r"^([LK])([0-9A-F]{4}):\s+(\S+)\s*(.*)$")
NAME = re.compile(r"^([A-Za-z_][A-Za-z0-9_]*):\s*(;.*)?$")
ALIAS = re.compile(r"^\.alias\s+([A-Za-z_][A-Za-z0-9_]*)\s+(\S+)\s*(;.*)?$")
DASH = ";" + "-" * 78
EQUAL = ";" + "=" * 78

class Line:
    __slots__ = ("addr", "prefix", "mn", "oper", "comment", "size", "names", "name_comments",
                 "pre", "header", "banner", "inner", "dpage", "lineno")
    def __repr__(self):
        return "<%s%04X %s %s>" % (self.prefix, self.addr, self.mn, self.oper)

def split_comment(rest):
    i = rest.find(";")
    if i < 0:
        return rest.rstrip(), None
    return rest[:i].rstrip(), rest[i + 1:]

def listing(path, end):
    """end: the address after the last byte of the listing."""
    lines = open(path).read().splitlines()
    out = []
    names, name_comments, pre, header, banner = [], {}, [], None, None
    dpage = 0
    i = 0
    while i < len(lines):
        ln = lines[i]
        s = ln.strip()
        m = ADDR.match(ln)
        if m:
            L = Line()
            L.prefix, L.addr, L.mn = m.group(1), int(m.group(2), 16), m.group(3)
            L.oper, L.comment = split_comment(m.group(4))
            L.names, L.name_comments, L.pre, L.header, L.banner = names, name_comments, pre, header, banner
            L.inner, L.dpage, L.lineno, L.size = [], dpage, i + 1, 0
            out.append(L)
            names, name_comments, pre, header, banner = [], {}, [], None, None
        elif s == DASH or s == EQUAL:
            block = []
            i += 1
            while i < len(lines) and lines[i].strip() not in (DASH, EQUAL):
                block.append(lines[i][1:].rstrip() if lines[i].startswith(";") else lines[i])
                i += 1
            if s == DASH:
                header = block
            else:
                banner = block
        elif s.startswith(".dpage"):
            dpage = int(s.split("$")[1], 16)
        elif ALIAS.match(s):
            m = ALIAS.match(s)
            if out and m.group(2).startswith("$"):
                out[-1].inner.append((m.group(1), int(m.group(2)[1:], 16)))
        elif NAME.match(s):
            m = NAME.match(s)
            names.append(m.group(1))
            if m.group(2):
                name_comments[m.group(1)] = m.group(2)[1:]
        elif s.startswith(";"):
            if out or names or pre:                     # skip the file's own heading
                pre.append(s[1:])
            elif not out and lines[i - 1].strip() == "" and i > 16:
                pre.append(s[1:])
        i += 1
    for k, L in enumerate(out):
        L.size = (out[k + 1].addr if k + 1 < len(out) else end) - L.addr
    return out

def defines(path):
    out = {}
    section = ""
    for ln in open(path).read().splitlines():
        s = ln.strip()
        if s.startswith(";---") and "[" in s:
            section = s[s.index("[") + 1:s.index("]")].strip()
            continue
        m = ALIAS.match(s)
        if m:
            v = m.group(2)
            out[m.group(1)] = (v, section, m.group(3)[1:] if m.group(3) else "")
    return out
