#!/usr/bin/env python3
"""Align Markdown tables: every column padded to its longest cell.

Usage: fmt_tables.py check|apply [--shared] <file.md>...
  --shared  tables with the same number of columns share column widths (used for the index README)
Tables inside ``` fences are ignored; CRLF line endings are preserved. check exits 1 if any table is misaligned.
Tests: python3 tools/test_fmt_tables.py
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

def parse(lines):
    rows = [split_row(l) for l in lines]
    n = max(len(r) for r in rows)
    rows = [r + [''] * (n - len(r)) for r in rows]
    sep_idx = 1 if len(rows) > 1 and is_sep(rows[1]) else None
    return rows, sep_idx

def col_widths(rows, sep_idx, widths=None):
    widths = widths or [3] * len(rows[0])
    for ri, r in enumerate(rows):
        if ri == sep_idx: continue
        for ci, c in enumerate(r): widths[ci] = max(widths[ci], len(c))
    return widths

def fmt_table(lines, shared=None):
    rows, sep_idx = parse(lines)
    widths = col_widths(rows, sep_idx, list(shared.get(len(rows[0]), [])) or None) if shared else col_widths(rows, sep_idx)
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

def blocks(lines):
    # yield (is_table, lines) - each table as one block, every other line on its own
    i, fence = 0, False
    while i < len(lines):
        if lines[i].lstrip().startswith('```'): fence = not fence
        if not fence and lines[i].startswith('|'):
            j = i
            while j < len(lines) and lines[j].startswith('|'): j += 1
            yield True, lines[i:j]; i = j; continue
        yield False, [lines[i]]; i += 1

def padded_widths(block, sep_idx, n):
    # existing width of each column (cell text plus padding, less the single space either side) - so --shared keeps
    # any deliberate extra padding instead of shrinking every row
    widths = [0] * n
    for ri, line in enumerate(block):
        if ri == sep_idx: continue
        raw = line.strip()[1:-1].split('|') if line.strip().endswith('|') else []
        if len(raw) != n: continue
        for ci, c in enumerate(raw): widths[ci] = max(widths[ci], len(c.rstrip()) - 1 if c.strip() == '' else len(c) - 2)
    return widths

def shared_widths(lines):
    shared = {}
    for is_table, block in blocks(lines):
        if not is_table: continue
        rows, sep_idx = parse(block)
        n = len(rows[0])
        widths = col_widths(rows, sep_idx, shared.get(n))
        shared[n] = [max(a, b) for a, b in zip(widths, padded_widths(block, sep_idx, n))]
    return shared

def process(text, shared=False):
    lines, out, changed = text.split('\n'), [], 0
    widths = shared_widths(lines) if shared else None
    for is_table, block in blocks(lines):
        new = fmt_table(block, widths) if is_table else block
        if new != block: changed += 1
        out += new
    return '\n'.join(out), changed

if __name__ == '__main__':
    apply = sys.argv[1] == 'apply'
    shared = '--shared' in sys.argv[2:]
    misaligned = False
    for p in [a for a in sys.argv[2:] if a != '--shared']:
        t = open(p, encoding='utf-8', newline='').read()
        crlf = '\r\n' in t
        t2, n = process(t.replace('\r\n', '\n'), shared)
        print(f"{p}: {n} table(s) {'reformatted' if apply else 'misaligned'}")
        misaligned = misaligned or n > 0
        if apply and n:
            open(p, 'w', encoding='utf-8', newline='').write(t2.replace('\n', '\r\n') if crlf else t2)
    # check fails when anything is misaligned, so scripts can rely on it
    sys.exit(1 if misaligned and not apply else 0)
