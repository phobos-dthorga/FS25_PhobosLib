# Shared-Code Admission

Shared code belongs in `FS25_PhobosLib` only when it lowers real maintenance
cost across Phobos FS25 mods.

## Good Candidates

- logging and namespaced warnings;
- mod detection and guarded optional integration helpers;
- fill type lookup helpers;
- nil-safe XML read/write wrappers;
- savegame path helpers after runtime verification;
- small constants or compatibility helpers that have at least two real users.

## Poor Candidates

- gameplay rules for one mod;
- economy balance values;
- placeable, vehicle, map, or asset ownership;
- speculative abstractions with no immediate consumer;
- wrappers that hide important FS25 lifecycle behavior.

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
