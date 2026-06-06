# FS25_PhobosLib

Shared Lua utility library for Phobos Farming Simulator 25 mods.

## Status

Early staging project. The first goal is to provide a small, stable namespace for shared helpers used by Phobos FS25 mods.

## Intended Scope

- logging helpers
- mod and fill type detection helpers
- XML helper functions
- guarded optional-integration helpers
- version and compatibility checks
- small constants shared across Phobos FS25 mods

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

## Author

phobosgekko

## License

This project uses dual licensing:

- **Code** (Lua scripts, XML definitions, tools, and documentation): [MIT License](LICENSE)
- **Assets** (textures, icons, images, models, and other media): [CC BY-NC-SA 4.0](LICENSE-CC-BY-NC-SA.txt)

Forks and addons are encouraged. Code is permissively licensed for integration. Assets are protected from commercial use and must preserve attribution and ShareAlike terms.

