# Shared-Code Admission

This repository is retired for FS25 runtime use. Shared FS25 helper patterns
should be kept local to each consuming mod and documented as copyable
conventions unless the repository is explicitly un-retired.

## Good Candidates

- logging and namespaced warnings;
- once-only logging for optional integrations and one-time runtime diagnostics;
- translation fallback helpers;
- mod detection and guarded optional integration helpers;
- fill type lookup helpers;
- nil-safe XML read/write wrappers;
- nil-safe `XMLFile` object helpers;
- mod settings path helpers;
- savegame path helpers after runtime verification;
- small constants or compatibility helpers that have at least two real users.

## Poor Candidates

- gameplay rules for one mod;
- economy balance values;
- placeable, vehicle, map, or asset ownership;
- speculative abstractions with no immediate consumer;
- wrappers that hide important FS25 lifecycle behavior.
- save/load hook installation before a consumer proves the hook path at
  runtime.

## Admission Checklist

- Which mod needs this now?
- Which second mod is likely to use it soon?
- Can the helper remain dependency-free?
- Is the FS25 API behavior verified against local references, GIANTS LUADOC, or
  proven source examples?
- Is the helper bounded and compatible with the performance targets?
- Does the helper avoid persistent state unless that state is clearly a library
  responsibility?

If the answer is uncertain, keep the code local until a second real user
appears.

Historical note: `v0.1.2.0` admitted i18n, settings-path, XMLFile, and
once-only logging helpers because Rural Ledger and BgaExtensions both had
matching glue code. Runtime testing later showed the FS25 shared-helper package
added dependency and visibility friction, so those patterns have moved back to
self-contained mod-local helpers.
