# API Stability

`FS25_PhobosLib` should feel boring to consume. Once a helper is used by a
Phobos FS25 mod, the helper becomes part of the public contract.

## Stability Levels

## Stable

Stable helpers may be used by dependent mods without extra guards beyond normal
nil-safe use. A stable helper should not change argument order, return shape, or
side effects during the same major compatibility line.

Current stable helpers:

- `PhobosFS25.getName`
- `PhobosFS25.getVersion`
- `PhobosFS25.Logging.info`, `warn`, `error`
- `PhobosFS25.Logging.infoSource`, `warnSource`, `errorSource`
- `PhobosFS25.Mods.isLoaded`, `allLoaded`, `anyLoaded`, `requireLoaded`
- `PhobosFS25.FillTypes.getIndex`, `getIndexByName`, `exists`,
  `requireIndex`
- `PhobosFS25.Xml` getter and setter wrappers
- `PhobosFS25.Integrations.withOptionalMod`, `withRequiredMod`, `isAvailable`

## Provisional

Provisional helpers are usable for local experiments but should not be treated
as final until FS25 runtime verification is recorded.

Current provisional helpers:

- `PhobosFS25.Savegames.getCurrentSavegameDirectory`
- `PhobosFS25.Savegames.buildSavegamePath`
- `PhobosFS25.Savegames.buildSavegameXmlPath`
- `PhobosFS25.Savegames.canUseSavegameXml`

The savegame path helpers are based on observed FS25 mod patterns and the
current GIANTS LUADOC, but the save hook itself is not part of the public
library contract yet.

## Breaking Changes

Breaking changes require:

- a documented reason;
- an affected-mods list;
- a migration note;
- a version bump;
- validation in every dependent Phobos FS25 mod before release.
