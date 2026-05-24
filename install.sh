#!/usr/bin/env bash
# Install helper for Project JSON Schema.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/SPhillips1337/Project-JSON-Schema/main/install.sh | bash
#
# Optional environment variables:
#   TARGET_DIR=/path/to/project-json-schema  Directory to clone/use (default: ./project-json-schema)
#   REPO_URL=https://github.com/...           Repository URL to clone
#   SKIP_TESTS=1                              Skip npm test after installing dependencies

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/SPhillips1337/Project-JSON-Schema.git}"
TARGET_DIR="${TARGET_DIR:-project-json-schema}"
SKIP_TESTS="${SKIP_TESTS:-0}"

log() {
  printf '\033[1;34m[project-json-schema]\033[0m %s\n' "$*"
}

fail() {
  printf '\033[1;31m[project-json-schema]\033[0m %s\n' "$*" >&2
  exit 1
}

need_command() {
  command -v "$1" >/dev/null 2>&1 || fail "Required command not found: $1"
}

need_command git
need_command node
need_command npm

NODE_MAJOR="$(node -p 'Number(process.versions.node.split(".")[0])')"
if [ "$NODE_MAJOR" -lt 16 ]; then
  fail "Node.js 16 or newer is required. Found: $(node --version)"
fi

validate_repo_dir() {
  local dir="$1"

  [ -f "$dir/package.json" ] || fail "Missing package.json in $dir"
  [ -d "$dir/schema" ] || fail "Missing schema/ directory in $dir"
  [ -d "$dir/templates" ] || fail "Missing templates/ directory in $dir"

  local package_name
  package_name="$(cd -- "$dir" && node -p 'require("./package.json").name')"
  [ "$package_name" = "project-json-schema" ] || fail "Unexpected package name in $dir: $package_name"
}

if [ -f "package.json" ] && [ -d "schema" ] && [ -d "templates" ]; then
  validate_repo_dir "$(pwd)"
  log "Detected Project JSON Schema repository at $(pwd); installing in place."
  REPO_DIR="$(pwd)"
else
  if [ -e "$TARGET_DIR" ] && [ ! -d "$TARGET_DIR/.git" ]; then
    fail "TARGET_DIR exists but is not a git repository: $TARGET_DIR"
  fi

  if [ -d "$TARGET_DIR/.git" ]; then
    validate_repo_dir "$TARGET_DIR"
    log "Using existing Project JSON Schema clone: $TARGET_DIR"
    REPO_DIR="$TARGET_DIR"
  else
    log "Cloning $REPO_URL into $TARGET_DIR"
    git clone -- "$REPO_URL" "$TARGET_DIR"
    validate_repo_dir "$TARGET_DIR"
    REPO_DIR="$TARGET_DIR"
  fi
fi

cd -- "$REPO_DIR"

log "Installing npm dependencies"
if [ -f package-lock.json ] || [ -f npm-shrinkwrap.json ]; then
  npm ci
else
  npm install
fi

if [ "$SKIP_TESTS" != "1" ]; then
  log "Validating schema, template, and examples"
  npm test
else
  log "Skipping tests because SKIP_TESTS=1"
fi

log "Installation complete"
log "Try: cd $REPO_DIR && npm run validate"
