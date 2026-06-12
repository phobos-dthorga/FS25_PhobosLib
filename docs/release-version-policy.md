# Release And Version Policy

`FS25_PhobosLib` releases should be conservative because every dependent Phobos
FS25 mod inherits the library surface.

## Versioning

Use four-part FS25 mod versions: `major.minor.patch.build`.

- Increment `major` only for intentional breaking changes.
- Increment `minor` for new public helpers or behavior that dependent mods can
  consume.
- Increment `patch` for compatible fixes and documentation/tooling updates.
- Use `build` for release packaging corrections when needed.

## Release Checklist

- Update `modDesc.xml` and `src/PhobosFS25.lua` to the same version.
- Run static validation.
- Build a package set with SHA256 and package JSON metadata.
- Confirm the package does not include repository-only folders.
- Launch FS25 with at least one tiny dependent mod or a current Phobos consumer.
- Check `log.txt` for Phobos-owned errors, warnings, and repeated warnings.
- Review `docs/performance-targets.md`; do not release with a known hard miss.
- If savegame behavior changed, test a disposable save/load cycle.

## Release Assets

The primary release asset should be:

```text
FS25_PhobosLib_vX.Y.Z.W.zip
```

Keep release notes focused on public helper additions, compatibility impact,
runtime verification, and any known log lines.
