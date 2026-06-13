# Repository Stewardship

## Current Stewardship State

- Public GitHub repository created.
- Initial FS25 library scaffold committed.
- Dual licensing added to match nearby Phobos mod repositories.
- Issue templates and pull request template are present.
- CI packaging and validation are staged.
- Performance targets are documented and part of the PR/release gate.
- `v0.1.2.0` adds shared i18n fallback, once-only logging, mod-settings path,
  `XMLFile`, and log-triage helpers after Rural Ledger and BgaExtensions both
  showed matching glue-code needs.
- Retired for FS25 runtime use after Rural Ledger proved local XML/save
  fallbacks were more reliable than shared-helper runtime visibility.
- Release publishing is disabled; keep the repository for history and archived
  reference only.

## Still To Decide

- Whether FS25 ever proves a safer shared-code mechanism. Until then, current
  Phobos FS25 mods should remain self-contained.

## License Decision

This repository follows the established pattern from nearby Phobos Project Zomboid mod repositories:

- Code, XML definitions, tools, and documentation: MIT License.
- Assets, textures, icons, images, models, and other media: Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International.

If a future file needs different treatment, document that exception near the file and in the README.

## Performance Gate

If a hard miss is discovered, new feature work stops in this repository until
the target is met again. Allowed work is limited to fixing, measuring,
documenting, splitting, or removing the cause.

Review `docs/performance-targets.md` before feature merges and releases.
