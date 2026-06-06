# FS25_PhobosLib Agent Notes

These notes guide AI/code-agent work in this repository.

## Purpose

`FS25_PhobosLib` is the shared utility foundation for Phobos Farming Simulator 25 mods.

Keep it small, boring, stable, and dependency-free wherever possible. Shared code added here becomes a promise to future Phobos mods.

## FS25 API Rule

Do not guess FS25 Lua APIs from memory. Before adding or changing any FS25 Lua API call, class usage, lifecycle hook, specialization, GUI call, save/load call, network event, economy call, or placeable interaction, verify against local FS25 references or proven source examples.

If local references are not yet configured for this repository, pause and ask for their location before implementing API-sensitive code.

## Public Namespace

All shared Lua functionality must live under one global namespace:

```lua
PhobosFS25
```

Do not create additional globals unless FS25 requires a registered class or specialization name.

## Library Boundary

Good candidates:

- logging helpers
- version checks
- XML helper functions
- mod detection helpers
- fill type lookup helpers
- guarded hook helpers
- optional integration helpers

Poor candidates:

- gameplay rules specific to one mod
- balance numbers specific to one mod
- assets or placeables owned by another mod
- speculative abstractions without two real users

## Compatibility

- Keep helper signatures stable once used by another Phobos mod.
- Add new helpers instead of silently changing old behavior.
- Prefer explicit nil-safe return values over hard failures.
- Log warnings clearly when a requested integration target is missing.

