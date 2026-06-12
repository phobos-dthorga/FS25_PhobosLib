# Performance Targets

These targets apply to `FS25_PhobosLib` and should be mirrored by dependent
Phobos FS25 mods.

## Freeze Rule

If a hard miss is found, new feature development stops in the affected repo.
Allowed work is limited to fixing, measuring, documenting, splitting, or
removing the cause. Feature work resumes only after the repo is back at target
or below.

The freeze applies to the affected repo, not every Phobos FS25 repo.

## Log Health

- Release candidates must have no Phobos-owned `Error:` lines.
- Release candidates must have no Phobos-owned `Warning (` lines.
- Development builds must not produce repeated Phobos-owned runtime warnings.
- Any known warning accepted temporarily must be documented with owner, cause,
  and removal condition.

Phobos-owned means the log line clearly points at `FS25_PhobosLib`,
`PhobosFS25`, this repository's files, or a helper called by this library.

## Load Impact

- Target: less than 5 seconds added load time, or less than 10 percent over the
  baseline save.
- Hard miss: more than 10 seconds added load time, or more than 20 percent over
  baseline.

Measure baseline and Phobos-enabled loads on the same map, save, hardware, and
mod set except for the package being tested.

## Runtime Work

Hard misses:

- unbounded per-frame scans of all farms, fields, vehicles, placeables,
  fillTypes, active mods, or productions;
- repeated optional-integration warnings every frame or update tick;
- helpers that hide expensive full-world scans behind simple-looking calls.

Shared helpers should do bounded lookups, cache only when safe, and leave
gameplay-scale iteration to the consuming mod.

## Save Data

- Target: custom library-owned save data stays under 50 KB for normal MVP
  saves.
- Hard miss: unbounded or repeated save data growth without a documented cap.

`FS25_PhobosLib` should normally own little or no save data.

## Package Size And Assets

- Soft target: XML/Lua/package-light releases stay under 1 MB.
- Any intentional asset growth must be documented before release.
- DDS/icon raw-format warnings for Phobos-owned assets are hard misses.

## PR And Release Gate

Every PR and release review must answer:

- Are log-health targets met?
- Are load-impact targets met or unchanged?
- Are runtime loops bounded?
- Is save data bounded?
- Is the package still light, or is asset growth intentional and documented?
- Is there any hard miss that freezes new feature work?
