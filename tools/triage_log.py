#!/usr/bin/env python3
"""Shared FS25 log triage for Phobos-owned mods."""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
from datetime import datetime
from pathlib import Path


TIMESTAMP_RE = re.compile(r"^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3})")
FS25_USER_RELATIVE_PATH = Path("My Games") / "FarmingSimulator2025"
DEFAULT_OWNERS = (
    "FS25_PhobosLib",
    "PhobosFS25",
    "FS25_PhobosRuralLedger",
    "PhobosRuralLedger",
    "FS25_BgaExtensions",
    "GBWDataPacks",
    "GBWCompatSettings",
    "GBWWasteAwareGate",
    "/placeables/gbw/",
    "/scripts/gbw",
    "gbw_",
)


def parse_timestamp(line: str) -> str | None:
    match = TIMESTAMP_RE.match(line)
    return match.group(1) if match else None


def unique_paths(paths: list[Path]) -> list[Path]:
    result: list[Path] = []
    seen: set[str] = set()
    for path in paths:
        key = str(path.expanduser()).lower()
        if key in seen:
            continue
        seen.add(key)
        result.append(path.expanduser())
    return result


def candidate_log_paths(game_user_dir: str | None) -> list[Path]:
    candidates: list[Path] = []

    if game_user_dir:
        candidates.append(Path(game_user_dir) / "log.txt")

    env_log_path = os.environ.get("FS25_LOG_PATH")
    if env_log_path:
        candidates.append(Path(env_log_path))

    env_user_dir = os.environ.get("FS25_USER_DIR")
    if env_user_dir:
        candidates.append(Path(env_user_dir) / "log.txt")

    home = Path.home()
    candidates.append(home / "Documents" / FS25_USER_RELATIVE_PATH / "log.txt")

    user_profile = os.environ.get("USERPROFILE")
    if user_profile:
        candidates.append(Path(user_profile) / "Documents" / FS25_USER_RELATIVE_PATH / "log.txt")

    for env_name in ["OneDrive", "OneDriveConsumer", "OneDriveCommercial"]:
        one_drive = os.environ.get(env_name)
        if one_drive:
            candidates.append(Path(one_drive) / "Documents" / FS25_USER_RELATIVE_PATH / "log.txt")

    for start in [Path.cwd(), Path(__file__).resolve()]:
        current = start if start.is_dir() else start.parent
        candidates.extend(parent / FS25_USER_RELATIVE_PATH / "log.txt" for parent in [current, *current.parents])

    return unique_paths(candidates)


def resolve_log_path(log_arg: str | None, game_user_dir: str | None) -> tuple[Path | None, list[Path]]:
    if log_arg:
        return Path(log_arg).expanduser().resolve(), []

    searched = candidate_log_paths(game_user_dir)
    existing = [path for path in searched if path.is_file()]
    if not existing:
        return None, searched

    return max(existing, key=lambda path: path.stat().st_mtime).resolve(), searched


def is_owned_line(line: str, owners: list[str]) -> bool:
    lowered = line.lower().replace("\\", "/")
    return any(owner.lower().replace("\\", "/") in lowered for owner in owners)


def summarize_log(log_path: Path, owners: list[str]) -> dict[str, object]:
    lines = log_path.read_text(encoding="utf-8", errors="replace").splitlines()
    summary: dict[str, object] = {
        "log_path": str(log_path),
        "line_count": len(lines),
        "owners": owners,
        "first_timestamp": None,
        "last_timestamp": None,
        "owned_errors": [],
        "owned_warnings": [],
        "external_errors": [],
        "external_warnings": [],
        "owned_load_lines": [],
    }

    timestamps = [stamp for line in lines if (stamp := parse_timestamp(line))]
    if timestamps:
        summary["first_timestamp"] = timestamps[0]
        summary["last_timestamp"] = timestamps[-1]
        start = datetime.strptime(timestamps[0], "%Y-%m-%d %H:%M:%S.%f")
        end = datetime.strptime(timestamps[-1], "%Y-%m-%d %H:%M:%S.%f")
        summary["log_span_seconds"] = round((end - start).total_seconds(), 3)

    for line in lines:
        owned = is_owned_line(line, owners)

        if owned and ("Available mod:" in line or "Load mod:" in line):
            summary["owned_load_lines"].append(line)

        is_error = "Error:" in line or "[ERROR]" in line
        is_warning = "Warning" in line or "[WARN]" in line
        if not (is_error or is_warning):
            continue

        if owned:
            target = "owned_errors" if is_error else "owned_warnings"
        else:
            target = "external_errors" if is_error else "external_warnings"
        summary[target].append(line)

    return summary


def print_human_summary(summary: dict[str, object], max_lines: int) -> None:
    print(f"Log: {summary['log_path']}")
    print(f"Lines: {summary['line_count']}")
    if summary.get("first_timestamp"):
        print(f"First timestamp: {summary['first_timestamp']}")
    if summary.get("last_timestamp"):
        print(f"Last timestamp: {summary['last_timestamp']}")
    if summary.get("log_span_seconds") is not None:
        print(f"Log span: {summary['log_span_seconds']} seconds")
    print(f"Owners: {', '.join(summary['owners'])}")

    for label, key in [
        ("Owned load lines", "owned_load_lines"),
        ("Owned errors", "owned_errors"),
        ("Owned warnings", "owned_warnings"),
        ("External errors", "external_errors"),
        ("External warnings", "external_warnings"),
    ]:
        values = summary[key]
        assert isinstance(values, list)
        print(f"{label}: {len(values)}")
        for line in values[:max_lines]:
            print(f"  {line}")
        if len(values) > max_lines:
            print(f"  ... {len(values) - max_lines} more")


def main() -> int:
    parser = argparse.ArgumentParser(description="Summarize FS25 log lines relevant to Phobos-owned mods")
    parser.add_argument("--log", help="Path to FS25 log.txt")
    parser.add_argument("--game-user-dir", help="Path to the FarmingSimulator2025 user folder")
    parser.add_argument("--owner", action="append", help="Additional owner token to classify as Phobos-owned")
    parser.add_argument("--replace-default-owners", action="store_true", help="Use only --owner values")
    parser.add_argument("--summary-json", help="Optional path to write JSON summary")
    parser.add_argument("--max-lines", type=int, default=10, help="Max matching lines printed per category")
    parser.add_argument("--fail-on-owned-warning", action="store_true", help="Exit non-zero for owned warnings/errors")
    args = parser.parse_args()

    owners = [] if args.replace_default_owners else list(DEFAULT_OWNERS)
    owners.extend(args.owner or [])
    owners = [owner for owner in owners if owner]

    log_path, searched = resolve_log_path(args.log, args.game_user_dir)
    if log_path is None or not log_path.is_file():
        print("Log file not found.", file=sys.stderr)
        if searched:
            print("Checked:", file=sys.stderr)
            for candidate in searched:
                print(f"  {candidate}", file=sys.stderr)
        print("Pass --log or set FS25_LOG_PATH to the FS25 log.txt path.", file=sys.stderr)
        return 2

    summary = summarize_log(log_path, owners)
    print_human_summary(summary, args.max_lines)

    if args.summary_json:
        output = Path(args.summary_json).resolve()
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
        print(f"Wrote {output}")

    if args.fail_on_owned_warning and (summary["owned_errors"] or summary["owned_warnings"]):
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
