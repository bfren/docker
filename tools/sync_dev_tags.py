#!/usr/bin/env python3
"""Make each image's dev.yml push the same tags as its publish.yml, with a -dev suffix (latest becomes dev).

Run from the folder containing the image repositories:  python3 index/tools/sync_dev_tags.py [--apply]
Without --apply it only reports what would change. It also copies any read-file steps and push steps that
dev.yml is missing, and reports tag expressions that refer to undefined steps.
"""
import re, sys, os

STEP_SEP = '      -\n'

def split_steps(text):
    # returns (head, [steps]) where steps are the text after each '      -\n' marker (the first jobs' steps list only)
    # use the last job's steps - some workflows have a separate test job first
    i = text.rindex('    steps:\n') + len('    steps:\n')
    head, body = text[:i], text[i:]
    parts = body.split(STEP_SEP)
    assert parts[0] == '', 'unexpected content before first step'
    return head, parts[1:]

def join_steps(head, steps):
    return head + ''.join(STEP_SEP + s for s in steps)

def step_id(s):
    m = re.search(r'^        id: (\S+)$', s, re.M)
    return m.group(1) if m else None

def is_read(s): return 'uses: bfren/read-file' in s

def tags_block(s):
    m = re.search(r'^          tags: \|\n((?:            .*\n?)+)', s, re.M)
    return m

def dev_tag(line):
    ind = line[:len(line) - len(line.lstrip())]
    t = line.strip()
    repo, _, tag = t.rpartition(':') if not t.startswith('${{') else ('', '', t)
    # split image from tag on the last ':' that is not inside ${{ }}
    depth, cut = 0, -1
    for k in range(len(t)):
        if t.startswith('${{', k): depth += 1
        elif t.startswith('}}', k): depth -= 1
        elif t[k] == ':' and depth == 0: cut = k
    image, tag = t[:cut], t[cut+1:]
    tag = 'dev' if tag == 'latest' else tag + '-dev'
    return f'{ind}{image}:{tag}'

def process(repo, apply):
    wf = f'{repo}/.github/workflows'
    dev_p, pub_p = f'{wf}/dev.yml', f'{wf}/publish.yml'
    dev, pub = open(dev_p).read(), open(pub_p).read()
    dh, ds = split_steps(dev); ph, ps = split_steps(pub)
    notes = []
    # 1. read steps missing from dev
    dev_ids = {step_id(s) for s in ds}
    missing = [s for s in ps if is_read(s) and step_id(s) not in dev_ids]
    if missing:
        last = max(i for i, s in enumerate(ds) if is_read(s))
        ds = ds[:last+1] + missing + ds[last+1:]
        notes.append('added reads: ' + ','.join(step_id(s) for s in missing))
    # 2. tags for each push step, matched by id
    pub_push = {step_id(s): s for s in ps if tags_block(s)}
    for i, s in enumerate(ds):
        m = tags_block(s)
        if not m or 'load: true' in s: continue
        sid = step_id(s)
        if sid not in pub_push:
            notes.append(f'NO MATCH for dev step {sid}'); continue
        pm = tags_block(pub_push[sid])
        new = ''.join(dev_tag(l) + '\n' for l in pm.group(1).splitlines())
        old_n = len(m.group(1).splitlines())
        ds[i] = s[:m.start(1)] + new + s[m.end(1):]
        notes.append(f'{sid}: {old_n}->{len(new.splitlines())} tags')
    # push steps that only exist in publish (e.g. the default 'latest' build) - add a dev version after the last push step
    dev_push_ids = {step_id(s) for s in ds if tags_block(s)}
    push_expr = re.search(r'^          push: (.+)$', next(s for s in ds if step_id(s) == 'docker_build'), re.M).group(1)
    for sid, s in pub_push.items():
        if sid in dev_push_ids: continue
        s = s.replace('            BF_PUBLISHING=1\n', '').replace('          push: true\n', f'          push: {push_expr}\n')
        m = tags_block(s)
        s = s[:m.start(1)] + ''.join(dev_tag(l) + '\n' for l in m.group(1).splitlines()) + s[m.end(1):]
        last = max(i for i, x in enumerate(ds) if tags_block(x) and 'load: true' not in x)
        ds.insert(last + 1, s)
        notes.append(f'added push step {sid}')
    # check every referenced step id exists
    out = join_steps(dh, ds)
    ids = {step_id(s) for s in ds}
    refs = set(re.findall(r'steps\.(\w+)\.outputs', out))
    if refs - ids: notes.append('UNDEFINED refs: ' + ','.join(refs - ids))
    if 'BF_PUBLISHING' in out: notes.append('BF_PUBLISHING LEFT IN DEV')
    if apply and out != dev: open(dev_p, 'w').write(out)
    return notes

apply = '--apply' in sys.argv
for repo in sorted(os.listdir('.')):
    if not os.path.isfile(f'{repo}/.github/workflows/dev.yml'): continue
    try: print(f'{repo}: ' + '; '.join(process(repo, apply)))
    except Exception as e: print(f'{repo}: ERROR {e!r}')
