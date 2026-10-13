#!/usr/bin/env python3
"""Align Markdown tables: every column padded to its longest cell.

Usage: fmt_tables.py check|apply <file.md>...
Tables inside ``` fences are ignored; CRLF line endings are preserved.
"""
import sys, re

def split_row(line):
    s = line.strip()
    if s.startswith('|'): s = s[1:]
    if s.endswith('|') and not s.endswith('\\|'): s = s[:-1]
    cells, cur, tick = [], '', False
    i = 0
    while i < len(s):
        c = s[i]
        if c == '\\' and i + 1 < len(s) and s[i+1] == '|':
            cur += '\\|'; i += 2; continue
        if c == '`': tick = not tick
        if c == '|' and not tick:
            cells.append(cur.strip()); cur = ''
        else:
            cur += c
        i += 1
    cells.append(cur.strip())
    return cells

def is_sep(cells): return all(re.fullmatch(r':?-+:?', c) for c in cells if c != '') and len(cells) > 0

def fmt_table(lines):
    rows = [split_row(l) for l in lines]
    n = max(len(r) for r in rows)
    rows = [r + [''] * (n - len(r)) for r in rows]
    sep_idx = 1 if len(rows) > 1 and is_sep(rows[1]) else None
    widths = [3] * n
    for ri, r in enumerate(rows):
        if ri == sep_idx: continue
        for ci, c in enumerate(r): widths[ci] = max(widths[ci], len(c))
    out = []
    for ri, r in enumerate(rows):
        if ri == sep_idx:
            cells = []
            for ci, c in enumerate(r):
                w = widths[ci]
                l, rt = c.startswith(':'), c.endswith(':')
                cells.append((':' if l else '') + '-' * (w - l - rt) + (':' if rt else ''))
        else:
            cells = [c.ljust(widths[ci]) for ci, c in enumerate(r)]
        out.append('| ' + ' | '.join(cells) + ' |')
    return out

def process(text):
    lines, out, i, fence, changed = text.split('\n'), [], 0, False, 0
    while i < len(lines):
        l = lines[i]
        if l.lstrip().startswith('```'): fence = not fence
        if not fence and l.startswith('|'):
            j = i
            while j < len(lines) and lines[j].startswith('|'): j += 1
            block = lines[i:j]; new = fmt_table(block)
            if new != block: changed += 1
            out += new; i = j; continue
        out.append(l); i += 1
    return '\n'.join(out), changed

apply = sys.argv[1] == 'apply'
for p in sys.argv[2:]:
    t = open(p, encoding='utf-8', newline='').read()
    crlf = '\r\n' in t
    t2, n = process(t.replace('\r\n', '\n'))
    print(f"{p}: {n} table(s) {'reformatted' if apply else 'misaligned'}")
    if apply and n:
        open(p, 'w', encoding='utf-8', newline='').write(t2.replace('\n', '\r\n') if crlf else t2)
