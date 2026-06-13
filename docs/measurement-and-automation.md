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
- Lua smoke tests for shared helper behavior.

The validator can still be used for archival checks. Do not treat a passing
package build as approval to publish a new runtime release.

## Manual Runtime Recipe

Historical dependency-load smoke test:

- install `FS25_PhobosLib.zip`;
- install a tiny dependent test mod or a current Phobos consumer such as
  `FS25_PhobosRuralLedger`;
- load a disposable save;
- exercise the helper being tested;
- save, exit, reload if save behavior is involved;
- inspect `log.txt`.

For savegame helper stabilization, record the exact save/load result in a
runtime-test issue or release note.

Current FS25 mods should test their local helper paths without installing this
package.

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

Run the historical triage helper:

```powershell
python tools/triage_log.py --summary-json dist/current-log-summary.json
```

Or fail on Phobos-owned warnings/errors:

```powershell
python tools/triage_log.py --fail-on-owned-warning
```

The tool searches for:

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

For current Phobos FS25 mods, copy the triage convention locally rather than
adding a runtime dependency on this package.

## Automation Backlog

- Promote hook helper candidates only after a consumer proves the lifecycle in
  a disposable save.
- Add measured load-time records to release notes once runtime testing becomes
  regular.
- Add package-size trend checks if assets become part of the library.
