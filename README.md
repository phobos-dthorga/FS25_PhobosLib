# FS25_PhobosLib

Retired shared Lua utility-library experiment for Phobos Farming Simulator 25
mods.

## Status

Retired/read-only for FS25 runtime use. The repository remains intact for
history and reference, but no new FS25 runtime releases should be published and
current Phobos FS25 mods should not depend on this package.

Project Zomboid `PhobosLib` is unchanged; this retirement applies only to the
FS25 shared-library experiment.

## Intended Scope

- logging helpers
- once-only logging helpers
- translation fallback helpers
- mod and fill type detection helpers
- XML helper functions
- XMLFile object helper functions
- mod-settings path helpers
- guarded optional-integration helpers
- provisional savegame path helpers
- version and compatibility checks

## Out Of Scope

- mod-specific gameplay logic
- BGA-specific balance values
- placeables, vehicles, or assets owned by another mod
- broad framework code that has not yet been needed by at least two Phobos FS25 mods

## Usage

Do not add this package as a dependency for new or current Phobos FS25 mods.
Use local helper modules in each FS25 mod instead, and document reusable
patterns as copyable conventions.

## Public Helper Areas

- `PhobosFS25.Logging` - namespaced log lines and source-scoped warnings.
- `PhobosFS25.I18n` - nil-safe localized string lookup with formatted
  fallback text.
- `PhobosFS25.Mods` - active-mod checks.
- `PhobosFS25.FillTypes` - nil-safe fill type index lookups.
- `PhobosFS25.Xml` - nil-safe XML getter/setter wrappers and bounded indexed
  loops.
- `PhobosFS25.XmlFile` - nil-safe helpers for FS25 `XMLFile` objects.
- `PhobosFS25.ModSettings` - mod settings directory and settings XML path
  helpers.
- `PhobosFS25.Integrations` - guarded optional and required integration calls.
- `PhobosFS25.Savegames` - provisional savegame path helpers only.

## Packaging

Build and validate the package set with:

```powershell
python tools/package_set.py --validate --write-sha256 --write-json
```

Summarize a local FS25 log with:

```powershell
python tools/triage_log.py --summary-json dist/current-log-summary.json
```

Or build the local zip with:

```powershell
powershell -ExecutionPolicy Bypass -File tools/package.ps1
```

## Performance Gate

If a hard performance target miss is found, new feature development stops in
this repository until the target is met again. Allowed work is limited to
fixing, measuring, documenting, splitting, or removing the cause.

See `docs/performance-targets.md` and `docs/measurement-and-automation.md`.

## Documentation

Start with:

- `docs/retirement-notice.md`
- `docs/README.md`
- `docs/dependency-contract.md`
- `docs/api-stability.md`
- `docs/shared-code-admission.md`
- `docs/release-version-policy.md`
- `docs/savegame-reference.md`
- `docs/performance-targets.md`
- `docs/measurement-and-automation.md`

## Author

phobosgekko

## License

This project uses dual licensing:

- **Code** (Lua scripts, XML definitions, tools, and documentation): [MIT License](LICENSE)
- **Assets** (textures, icons, images, models, and other media): [CC BY-NC-SA 4.0](LICENSE-CC-BY-NC-SA.txt)

Forks and addons are encouraged. Code is permissively licensed for integration. Assets are protected from commercial use and must preserve attribution and ShareAlike terms.
