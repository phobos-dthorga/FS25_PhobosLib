# FS25_PhobosLib

Shared Lua utility library for Phobos Farming Simulator 25 mods.

## Status

Early shared-library foundation. The current goal is to provide a small, stable
namespace for helpers used by Phobos FS25 mods without turning the library into
mod-specific gameplay code.

## Intended Scope

- logging helpers
- mod and fill type detection helpers
- XML helper functions
- guarded optional-integration helpers
- provisional savegame path helpers
- version and compatibility checks

## Out Of Scope

- mod-specific gameplay logic
- BGA-specific balance values
- placeables, vehicles, or assets owned by another mod
- broad framework code that has not yet been needed by at least two Phobos FS25 mods

## Usage

Dependent mods should declare:

```xml
<dependencies>
    <dependency>FS25_PhobosLib</dependency>
</dependencies>
```

Lua helpers are exposed through the `PhobosFS25` global namespace.

## Public Helper Areas

- `PhobosFS25.Logging` - namespaced log lines and source-scoped warnings.
- `PhobosFS25.Mods` - active-mod checks.
- `PhobosFS25.FillTypes` - nil-safe fill type index lookups.
- `PhobosFS25.Xml` - nil-safe XML getter/setter wrappers and bounded indexed
  loops.
- `PhobosFS25.Integrations` - guarded optional and required integration calls.
- `PhobosFS25.Savegames` - provisional savegame path helpers only.

## Packaging

Build and validate the package set with:

```powershell
python tools/package_set.py --validate --write-sha256 --write-json
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
