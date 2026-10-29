# Build workflow

Every image builds with the reusable workflow in [.github/workflows/build.yml](../.github/workflows/build.yml).
Each image has one small workflow that calls it - copy [build.yml](build.yml) to
`<image>/.github/workflows/build.yml` and fill it in. It replaces `dev.yml` and `publish.yml`.

## What it does

- **Branch pushes** build, test and push development images - `-dev` is added to every tag, and `latest` becomes `dev`.
- **Published releases** build and push release images with `BF_PUBLISHING=1` (which removes the tests).
- Each folder is built for each platform on its own runner: amd64 and arm64 natively, anything else using QEMU.
  Tests run on the native platforms. The platforms are then joined into one multi-platform image per folder.

## The two rules for tags

1. **A tag can use `${FOLDER}` and any version file as a variable** - `${VERSION}`, `${VERSION_MAJOR}` and
   `${VERSION_MINOR}` from the repository, or the name of any upper-case file in the folder, the folder's
   `overlay/tmp`, or the repository's `overlay/tmp` (e.g. `ALPINE_REVISION` becomes `${ALPINE_REVISION}`).
2. **Never write `-dev`** - development builds add it.

If a tag uses a variable with no matching file, the build stops and says which variable it could not find.

Only give `latest` to images with a single Dockerfile. Images with several versions leave it out so users choose a
version - except Alpine, which other images and scripts use untagged.

## Examples

### A single image - Unbound

No `folders`: the Dockerfile is in the repository root. The application version comes from
`overlay/tmp/UNBOUND_MAJOR`, `UNBOUND_MINOR` and `UNBOUND_REVISION`.

```yaml
      image: unbound
      platforms: |
        linux/amd64
        linux/arm/v7
        linux/arm64
      publish: ${{ github.event_name == 'release' }}
      tags: |
        latest
        ${VERSION_MAJOR}
        ${VERSION_MINOR}
        ${VERSION}
        unbound${UNBOUND_MAJOR}
        unbound${UNBOUND_MAJOR}-${VERSION}
        unbound${UNBOUND_MINOR}
        unbound${UNBOUND_MINOR}-${VERSION}
        unbound${UNBOUND_REVISION}
```

Gives `latest`, `3`, `3.1`, `3.1.17`, `unbound1`, `unbound1-3.1.17`, `unbound1.26`, `unbound1.26-3.1.17` and
`unbound1.26.2`.

### Version folders - Alpine

One folder per Alpine version, each with an `ALPINE_REVISION` file. The newest version also gets the default tags.

```yaml
      image: alpine
      folders: |
        3.15
        …
        3.24
      platforms: |
        linux/amd64
        linux/arm/v7
        linux/arm64
      publish: ${{ github.event_name == 'release' }}
      tags: |
        alpine${FOLDER}
        alpine${FOLDER}-${VERSION_MAJOR}
        alpine${FOLDER}-${VERSION_MINOR}
        alpine${FOLDER}-${VERSION}
        alpine${ALPINE_REVISION}
        alpine${ALPINE_REVISION}-${VERSION}
      default-folder: "3.24"
      default-tags: |
        latest
        ${VERSION_MAJOR}
        ${VERSION_MINOR}
        ${VERSION}
```

For 3.24 gives `alpine3.24`, `alpine3.24-3`, `alpine3.24-3.5`, `alpine3.24-3.5.1`, `alpine3.24.2`,
`alpine3.24.2-3.5.1`, then `latest`, `3`, `3.5` and `3.5.1`.

### Version folders with an application - WordPress

One folder per PHP version (already named `php8.4` etc., so `${FOLDER}` needs no prefix), each with a `PHP_REVISION`
file. The WordPress version comes from `overlay/tmp/WP_MINOR` and `WP_VERSION` in the repository root. No `latest`.

```yaml
      image: wordpress
      folders: |
        php8.2
        …
        php8.5
      platforms: |
        linux/amd64
        linux/arm64
      publish: ${{ github.event_name == 'release' }}
      tags: |
        ${FOLDER}
        ${FOLDER}-${VERSION_MAJOR}
        ${FOLDER}-${VERSION_MINOR}
        ${FOLDER}-${VERSION}
        ${FOLDER}-wp${WP_MINOR}
        ${FOLDER}-wp${WP_MINOR}-${VERSION}
        ${FOLDER}-wp${WP_VERSION}
        ${FOLDER}-wp${WP_VERSION}-${VERSION}
        php${PHP_REVISION}
```

For `php8.4` gives `php8.4`, `php8.4-7`, `php8.4-7.2`, `php8.4-7.2.1`, `php8.4-wp7.1`, `php8.4-wp7.1-7.2.1`,
`php8.4-wp7.1.3`, `php8.4-wp7.1.3-7.2.1` and `php8.4.26`.

## Moving an image to the workflow

1. Copy [build.yml](build.yml) to `<image>/.github/workflows/build.yml`, and copy the tags from the image's
   `publish.yml`, changing `${{ steps.x.outputs.contents }}` to `${X}` (the file name) and `${{ matrix.x }}` to `${FOLDER}`.
2. Delete `dev.yml` and `publish.yml`, and point the README's workflow badge at `build.yml`.
3. Push a branch and check the `-dev` tags in the run's merge jobs.

The repository needs the `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN` and `QUAY_TOKEN` secrets. Quay.io logs in as the
repository owner (`bfren`), unless a `QUAY_USERNAME` secret is passed as well.
