# Release And Version Policy

`FS25_PhobosLib` is retired for FS25 runtime use. Do not publish new release
packages from this repository.

## Versioning

Use four-part FS25 mod versions: `major.minor.patch.build`.

- Increment `major` only for intentional breaking changes.
- Increment `minor` for new public helpers or behavior that dependent mods can
  consume.
- Increment `patch` for compatible fixes and documentation/tooling updates.
- Use `build` for release packaging corrections when needed.

## Historical Release Checklist

- Do not use this checklist for new runtime releases unless the repository is
  explicitly un-retired.
- Historical releases updated `modDesc.xml` and `src/PhobosFS25.lua` to the
  same version.
- Run static validation.
- Build a package set with SHA256 and package JSON metadata.
- Confirm the package does not include repository-only folders.
- Historical releases launched FS25 with at least one tiny dependent test mod or
  then-current Phobos consumer.
- Check `log.txt` for Phobos-owned errors, warnings, and repeated warnings.
- Review `docs/performance-targets.md`; do not release with a known hard miss.
- If savegame behavior changed, test a disposable save/load cycle.

## Automated Release Workflow

`.github/workflows/release.yml` is now a retired notice workflow. It fails
intentionally on tag pushes or manual dispatch so no new FS25 helper package is
published by accident.

## Release Assets

Historical release assets used:

```text
FS25_PhobosLib_vX.Y.Z.W.zip
```

Historical release notes focused on public helper additions, compatibility
impact, runtime verification, and any known log lines.
