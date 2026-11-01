#!/usr/bin/env python3
"""Self-check for fmt_tables.py - run with: python3 tools/test_fmt_tables.py"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fmt_tables import split_row, process

# an escaped pipe and a pipe inside backticks stay in their cell
assert split_row(r'| a \| b | c |') == [r'a \| b', 'c']
assert split_row('| `x | y` | z |') == ['`x | y`', 'z']

# a misaligned table is padded, with the separator row matching
messy = '| A | Long header |\n|---|---|\n| value | x |'
aligned = '| A     | Long header |\n| ----- | ----------- |\n| value | x           |'
assert process(messy) == (aligned, 1)

# an aligned table is left alone, and tables inside ``` fences are ignored
assert process(aligned) == (aligned, 0)
assert process('```\n| a | b |\n```') == ('```\n| a | b |\n```', 0)

# --shared gives tables with the same number of columns the same widths
assert process('| a | b |\n\n| long | b |', shared=True) == ('| a    | b   |\n\n| long | b   |', 2)

print('fmt_tables: all checks passed')
