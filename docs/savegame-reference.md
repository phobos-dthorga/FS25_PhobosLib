# Savegame Reference

Savegame helpers are useful shared code, but they are also API-sensitive. Keep
them provisional until disposable-save testing confirms the behavior in FS25.

## Current Library Scope

`PhobosFS25.Savegames` currently exposes path helpers only:

- `getCurrentSavegameDirectory(mission)`
- `buildSavegamePath(fileName, mission)`
- `buildSavegameXmlPath(fileName, mission)`
- `canUseSavegameXml(mission)`

The library does not install a save hook, append mission behavior, or create a
save file by itself.

## Reference Pattern Observed In FS25_MoistureSystem

The third-party `FS25_MoistureSystem.zip` was inspected as a reference example
only. No code was copied.

Observed pattern:

- initialize from `loadMap`;
- use `g_currentMission.missionInfo.savegameDirectory` when available;
- fall back to `getUserProfileAppPath()` plus `savegameIndex`;
- write a dedicated mod XML file in the savegame directory;
- delegate subsystem save/load work;
- append a save function through `FSBaseMission.saveSavegame`.

## Verification Before Stabilizing

Before the save path helper becomes stable, record a runtime test that:

- installs `FS25_PhobosLib` with a tiny dependent mod or Rural Ledger;
- loads a disposable save;
- writes and reads a dedicated XML file through the helper path;
- saves, exits, reloads, and confirms the data returns;
- checks `log.txt` for Phobos-owned errors and warnings.

Any save hook helper must be verified separately before entering the public
library contract.

## References

- [FS25 LUADOC](https://gdn.giants-software.com/documentation_scripting_fs25.php)
- [GIANTS XML APIs](https://gdn.giants-software.com/documentation_scripting_fs25.php?category=33&function=861&version=engine)
- [Mission save/load patterns](https://gdn.giants-software.com/documentation_scripting_fs25.php?category=58&class=566&version=script)
