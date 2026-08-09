#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${1:-}" ]]; then
  echo "Please specify container" >&2
  exit 1
fi

docker compose build --no-cache "$1" && docker compose up -d --force-recreate "$1"