# Dependency Contract

`FS25_PhobosLib` is the shared utility foundation for Phobos Farming Simulator
25 mods. Dependent mods must declare the library in `modDesc.xml`:

```xml
<dependencies>
    <dependency>FS25_PhobosLib</dependency>
</dependencies>
```

All public helpers live under the global `PhobosFS25` namespace. Dependent mods
must not assume any other library global exists.

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

- Treat helpers as nil-safe utilities, not as gameplay authorities.
- Keep mod-specific gameplay, balance, and UI code in the consuming mod.
- Guard optional integrations through `PhobosFS25.Integrations` or equivalent
  active-mod checks.
- Do not reach into private local functions or rely on file load order beyond
  the source file list in `modDesc.xml`.
- If a helper is missing, update the library intentionally instead of copying
  shared logic into multiple mods.

## Library Rules

- Remain dependency-free.
- Keep public helper signatures stable once a dependent mod uses them.
- Prefer adding a new helper over changing an established helper in place.
- Do not add save hooks, lifecycle hooks, or FS25 API-sensitive behavior without
  runtime verification in a disposable save.
- Keep hook installation local to the consuming mod until two consumers need
  the same proven helper.
