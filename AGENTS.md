# FS25_PhobosLib Agent Notes

These notes guide AI/code-agent work in this repository.

## Purpose

`FS25_PhobosLib` is retired for Phobos Farming Simulator 25 runtime use.

Keep the repository intact for historical source, docs, and archived reference
only. Do not add new helpers, do not add new dependent FS25 mods, and do not
prepare new runtime releases from this repository.

## FS25 API Rule

Do not guess FS25 Lua APIs from memory. Before adding or changing any FS25 Lua API call, class usage, lifecycle hook, specialization, GUI call, save/load call, network event, economy call, or placeable interaction, verify against local FS25 references or proven source examples.

If local references are not yet configured for this repository, pause and ask for their location before implementing API-sensitive code.

## Historical Public Namespace

Existing historical Lua functionality lives under one global namespace:

```lua
PhobosFS25
```

Do not extend this surface unless the repository is explicitly un-retired.

## Library Boundary

Former good candidates, now better kept as local per-mod helpers:

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

- Current Phobos FS25 mods should be self-contained.
- Shared FS25 patterns should be documented as copyable conventions.
- Project Zomboid `PhobosLib` is unaffected.

## Performance Gate

Review `docs/performance-targets.md` before adding features or preparing a
release.

If a hard miss is found, halt new feature development in this repository until
the target is met again. Allowed work is limited to fixing, measuring,
documenting, splitting, or removing the cause.

Hard misses include Phobos-owned release-candidate errors or warnings, repeated
runtime warnings, unbounded per-frame world scans, unbounded save data growth,
and raw-format warnings for Phobos-owned DDS/icon assets.

## Packaging And Validation

- Do not propose a new FS25 runtime release from this repository.
- Existing validation commands may still be used for archival checks.
- Keep root-level package output clean: `docs/`, `tools/`, `.github/`, and
  repository-only files must not enter the zip.
- Runtime behavior, save hooks, and log health still require an FS25 launch.
