# API Stability

This file records the historical API surface from the retired FS25 helper
experiment. Current Phobos FS25 mods should not consume this package at
runtime.

## Stability Levels

## Stable

Historically stable helpers were intended for dependent mods without extra
guards beyond normal nil-safe use. Do not add new consumers unless this
repository is explicitly un-retired.

Current stable helpers:

- `PhobosFS25.getName`
- `PhobosFS25.getVersion`
- `PhobosFS25.Logging.info`, `warn`, `error`
- `PhobosFS25.Logging.infoSource`, `warnSource`, `errorSource`
- `PhobosFS25.Logging.infoOnceSource`, `warnOnceSource`, `errorOnceSource`,
  `resetOnceCache`
- `PhobosFS25.I18n.get`
- `PhobosFS25.Mods.isLoaded`, `allLoaded`, `anyLoaded`, `requireLoaded`
- `PhobosFS25.FillTypes.getIndex`, `getIndexByName`, `exists`,
  `requireIndex`
- `PhobosFS25.Xml` getter and setter wrappers
- `PhobosFS25.XmlFile` load/create, getter, setter, iteration, save, and
  delete wrappers
- `PhobosFS25.ModSettings.getDirectory`, `ensureDirectory`, `buildPath`,
  `buildXmlPath`
- `PhobosFS25.Integrations.withOptionalMod`, `withRequiredMod`, `isAvailable`

## Provisional

Provisional helpers were usable for local experiments but should not be treated
as final.

Current provisional helpers:

- `PhobosFS25.Savegames.getCurrentSavegameDirectory`
- `PhobosFS25.Savegames.buildSavegamePath`
- `PhobosFS25.Savegames.buildSavegameXmlPath`
- `PhobosFS25.Savegames.canUseSavegameXml`

The savegame path helpers are based on observed FS25 mod patterns and the
current GIANTS LUADOC, but the save hook itself is not part of the public
library contract yet.

Hook helpers remain out of scope for this retired repository. Current FS25 mods
should keep save/load hook wiring local.

## Breaking Changes

Breaking changes require:

- explicit un-retirement approval;
- a documented reason;
- an affected-mods list;
- a migration note;
- a version bump;
- validation in every dependent Phobos FS25 mod before release.
