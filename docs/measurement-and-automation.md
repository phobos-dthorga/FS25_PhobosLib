# Measurement And Automation

CI can prove package shape and syntax. FS25 runtime behavior still needs a
local launch and log review.

## Automated Checks

Run:

```powershell
python tools/package_set.py --validate --write-sha256 --write-json
```

CI also performs:

- Python tool compilation;
- Lua syntax compilation;
- package build;
- package validation;
- artifact upload.

The validator checks required docs, `modDesc.xml`, referenced source files,
dependency-free library status, expected package entries, and repository-only
paths accidentally included in the zip.

## Manual Runtime Recipe

For a dependency-load smoke test:

- install `FS25_PhobosLib.zip`;
- install a tiny dependent test mod or a current Phobos consumer such as
  `FS25_PhobosRuralLedger`;
- load a disposable save;
- exercise the helper being tested;
- save, exit, reload if save behavior is involved;
- inspect `log.txt`.

For savegame helper stabilization, record the exact save/load result in a
runtime-test issue or release note.

## Load-Time Measurement

Record:

- map and save name;
- FS25 game version;
- enabled mods;
- package version or commit;
- baseline load time;
- Phobos-enabled load time;
- added seconds and percent over baseline.

Use the same save and mod set except for the package under test.

## Log Triage

Search for:

- `Error:`
- `Warning (`
- `FS25_PhobosLib`
- `PhobosFS25`
- dependent-mod names that call into the library

Classify each Phobos-owned line as:

- expected and documented;
- soft miss;
- hard miss;
- unrelated external mod issue.

Known temporary lines should be documented near the affected repo before new
features continue.

## Automation Backlog

- Add a shared log-triage helper once two repos need the same parsing rules.
- Add measured load-time records to release notes once runtime testing becomes
  regular.
- Add package-size trend checks if assets become part of the library.
