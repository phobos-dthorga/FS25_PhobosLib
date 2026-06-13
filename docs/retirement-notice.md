# Retirement Notice

`FS25_PhobosLib` is retired for Farming Simulator 25 runtime use.

The shared-library idea remains valid in environments with reliable dependency
visibility, but FS25 runtime testing showed repeated friction around helper
global visibility, release sequencing, dependency installation, and downstream
validation. Current Phobos FS25 mods should be self-contained and keep small
helper patterns local to the mod that uses them.

## Repository Posture

- Keep this repository intact for history and reference.
- Do not publish new FS25 runtime releases from this repository.
- Do not add new dependent FS25 mods.
- Do not require players or testers to install this package for current FS25
  Phobos mods.
- Keep Project Zomboid `PhobosLib` unchanged; this retirement applies only to
  the FS25 experiment.

## Reuse Direction

Reusable FS25 code should be documented as copyable conventions until FS25
proves a safer shared-code mechanism. Current self-contained helper categories
include logging, translation fallback, active-mod checks, fillType lookup,
settings paths, XMLFile access, save path resolution, and log triage rules.
