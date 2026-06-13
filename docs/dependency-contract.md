# Dependency Contract

`FS25_PhobosLib` is retired for Phobos Farming Simulator 25 runtime use. This
file is retained as historical documentation for the original dependency
contract.

Current Phobos FS25 mods must not declare this library in `modDesc.xml`.
Historical dependent mods declared:

```xml
<dependencies>
    <dependency>FS25_PhobosLib</dependency>
</dependencies>
```

All public helpers lived under the global `PhobosFS25` namespace. Current FS25
mods should keep local helper modules instead of relying on this global.

## Current Public Surface

- `PhobosFS25.getName()` and `PhobosFS25.getVersion()`
- `PhobosFS25.Logging`
- `PhobosFS25.I18n`
- `PhobosFS25.Mods`
- `PhobosFS25.FillTypes`
- `PhobosFS25.Xml`
- `PhobosFS25.XmlFile`
- `PhobosFS25.ModSettings`
- `PhobosFS25.Savegames`
- `PhobosFS25.Integrations`

## Consumer Rules

- Do not add this dependency to current or future Phobos FS25 mods.
- Treat helpers as nil-safe utilities, not as gameplay authorities.
- Keep mod-specific gameplay, balance, and UI code in the consuming mod.
- Guard optional integrations through `PhobosFS25.Integrations` or equivalent
  active-mod checks.
- Do not reach into private local functions or rely on file load order beyond
  the source file list in `modDesc.xml`.
- If a helper pattern is useful, document it as a copyable convention and keep
  runtime code local to each FS25 mod.

## Library Rules

- Remain dependency-free.
- Remain retired/read-only unless explicitly un-retired.
- Keep public helper signatures stable once a dependent mod uses them.
- Prefer adding a new helper over changing an established helper in place.
- Do not add save hooks, lifecycle hooks, or FS25 API-sensitive behavior without
  runtime verification in a disposable save.
- Keep hook installation local to the consuming mod until two consumers need
  the same proven helper.
