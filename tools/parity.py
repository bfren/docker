#!/usr/bin/env python3
"""Report how far each image's txiki.js port has got compared with its Nushell original.

Usage: parity.py [--summary] <nu-root> <tjs-root> [image...]
  e.g. python3 tools/parity.py ../docker images alpine
  With no images given, every image in <nu-root> that has an overlay is checked.

What is compared (names match ignoring case, '-' and '_', so chmod-r == chmodR):
  functions  etc/nu/scripts/<pkg>/<mod>.nu  `export def x`  ->  etc/tjs/scripts/<pkg>/<mod>.ts  `export function x`
             (`main` is the module itself; mod.nu / index.ts take the package name)
  tests      etc/nu/scripts/tests/<mod>.nu  `export def a__b` -> etc/tjs/scripts/tests/<mod>.ts `export function a__b`
  scripts    any other .nu file or nu-shebang file in the overlay -> the same path as .ts, or the same path with a
             tjs / tjsh shebang
"""
import os, re, sys

NU_DEF = re.compile(r'^export def (?:--\w+ )*"?([^"\[\s]+(?: [^"\[\s]+)*)"?', re.M)
TS_DEF = re.compile(r'^export (?:async )?function\s+(\w+)', re.M)

def norm(s): return re.sub(r'[-_\s]', '', s).lower()

def files(root, ext):
    for d, _, fs in os.walk(root):
        for f in fs:
            if f.endswith(ext): yield os.path.join(d, f)

def read(p):
    with open(p, encoding='utf-8', errors='replace') as f: return f.read()

def module_of(path, scripts):
    rel = os.path.relpath(path, scripts).replace(os.sep, '/')
    pkg, _, rest = rel.partition('/')
    mod = os.path.splitext(rest or pkg)[0]
    return pkg, (pkg if mod in ('mod', 'index') else mod)

def defs(scripts, ext, pattern):
    # {(pkg, key): display name} - key is 'mod.fn' for functions, 'mod.test' for tests
    out = {}
    if not os.path.isdir(scripts): return out
    for p in files(scripts, ext):
        # the test runner only loads files directly in tests/ - sub-folders hold helpers
        rel = os.path.relpath(p, scripts).replace(os.sep, '/')
        if rel.startswith('tests/') and rel.count('/') > 1: continue
        pkg, mod = module_of(p, scripts)
        for name in pattern.findall(read(p)):
            name = name.split(' ')[-1] if ext == '.nu' else name
            fn = mod if name in ('main', mod) else f'{mod}.{name}'  # a TS function named after its module stands in for nu's main
            out[(pkg, norm(fn))] = f'{pkg}/{fn}' if pkg != 'tests' else f'tests/{mod}: {name}'
    return out

def shebang_matches(p, pattern):
    try:
        with open(p, 'rb') as f: first = f.readline()
    except OSError: return False
    return first.startswith(b'#!') and re.search(pattern, first) is not None

def is_nu_shebang(p): return shebang_matches(p, rb'\bnu\b')

def scripts(overlay):
    # overlay-relative paths of nu scripts outside etc/nu/scripts
    out = []
    for d, _, fs in os.walk(overlay):
        rel_d = os.path.relpath(d, overlay).replace(os.sep, '/')
        if rel_d.startswith('etc/nu/scripts') or rel_d.startswith('etc/tjs'): continue
        for f in fs:
            p = os.path.join(d, f)
            if f.endswith('.nu') or is_nu_shebang(p): out.append(os.path.relpath(p, overlay).replace(os.sep, '/'))
    return sorted(out)

def script_ported(rel, overlay):
    p = os.path.join(overlay, rel)
    base = rel[:-3] if rel.endswith('.nu') else rel
    return os.path.exists(os.path.join(overlay, base + '.ts')) or shebang_matches(p, rb'\btjs\w*\b')

def compare(nu, tjs):
    split = lambda d: ({k: v for k, v in d.items() if k[0] != 'tests'}, {k: v for k, v in d.items() if k[0] == 'tests'})
    nu_fn, nu_t = split(defs(os.path.join(nu, 'etc/nu/scripts'), '.nu', NU_DEF))
    ts_fn, ts_t = split(defs(os.path.join(tjs, 'etc/tjs/scripts'), '.ts', TS_DEF))
    sc = scripts(nu)
    return {
        'functions': (len(nu_fn), [v for k, v in sorted(nu_fn.items()) if k not in ts_fn],
                      [v for k, v in sorted(ts_fn.items()) if k not in nu_fn]),
        'tests': (len(nu_t), [v for k, v in sorted(nu_t.items()) if k not in ts_t],
                  [v for k, v in sorted(ts_t.items()) if k not in nu_t]),
        'scripts': (len(sc), [s for s in sc if not script_ported(s, tjs)], []),
    }

def main(args):
    summary = '--summary' in args
    args = [a for a in args if a != '--summary']
    if len(args) < 2: sys.exit(__doc__)
    nu_root, tjs_root, images = args[0], args[1], args[2:]
    images = images or sorted(i for i in os.listdir(nu_root) if os.path.isdir(os.path.join(nu_root, i, 'overlay')))
    totals = {}
    for image in images:
        result = compare(os.path.join(nu_root, image, 'overlay'), os.path.join(tjs_root, image, 'overlay'))
        print(f'## {image}')
        for kind, (total, missing, extra) in result.items():
            done = total - len(missing)
            t = totals.setdefault(kind, [0, 0]); t[0] += done; t[1] += total
            print(f'  {kind:<10} {done:>4}/{total:<4} ported')
            if summary: continue
            for m in missing: print(f'    - {m}')
            for e in extra: print(f'    + {e} (tjs only - renamed?)')
    if len(images) > 1:
        print('## total')
        for kind, (done, total) in totals.items(): print(f'  {kind:<10} {done:>4}/{total:<4} ported')

if __name__ == '__main__':
    main(sys.argv[1:])
