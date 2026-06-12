#!/usr/bin/env python3
"""Cross-platform package builder for FS25_PhobosLib."""

from __future__ import annotations

import argparse
import zipfile
from pathlib import Path


ROOT_PACKAGE_ALLOWLIST = (
    "src/",
    "languages/",
    "xml/",
    "objects/",
    "textures/",
    "sounds/",
)
ROOT_PACKAGE_FILES = {
    "modDesc.xml",
    "icon.dds",
    "LICENSE",
    "LICENSE-CC-BY-NC-SA.txt",
}


def should_include(root_relative: str, source_is_repo_root: bool) -> bool:
    if not source_is_repo_root:
        return True

    if root_relative in ROOT_PACKAGE_FILES:
        return True

    return any(root_relative.startswith(prefix) for prefix in ROOT_PACKAGE_ALLOWLIST)


def package_mod(repo_root: Path, source_path: Path, output_path: Path) -> None:
    mod_root = source_path if source_path.is_absolute() else repo_root / source_path
    if not mod_root.is_dir():
        raise FileNotFoundError(f"Mod source folder not found: {mod_root}")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    if output_path.exists():
        output_path.unlink()

    source_is_repo_root = mod_root.resolve() == repo_root.resolve()

    with zipfile.ZipFile(output_path, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(mod_root.rglob("*")):
            if not path.is_file():
                continue

            relative_name = path.relative_to(mod_root).as_posix()
            if not should_include(relative_name, source_is_repo_root):
                continue

            archive.write(path, relative_name)


def main() -> int:
    parser = argparse.ArgumentParser(description="Build FS25_PhobosLib zip")
    parser.add_argument("--repo-root", default=".", help="Repository root")
    parser.add_argument("--source", default=".", help="Mod source folder relative to the repository root")
    parser.add_argument("--output", default="dist/FS25_PhobosLib.zip", help="Output zip path")
    args = parser.parse_args()

    repo_root = Path(args.repo_root).resolve()
    output_path = Path(args.output)
    if not output_path.is_absolute():
        output_path = repo_root / output_path

    package_mod(repo_root, Path(args.source), output_path)
    print(f"Created {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
