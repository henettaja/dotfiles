#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$HOME/.zshrc"
SOURCE="$DOTFILES_DIR/zsh/.zshrc"

log() {
  printf '==> %s\n' "$1"
}

fail() {
  printf 'Error: %s\n' "$1" >&2
  exit 1
}

main() {
  [[ -f "$SOURCE" ]] || fail "Missing source file: $SOURCE"

  if [[ -L "$TARGET" ]]; then
    local current_target
    current_target="$(readlink "$TARGET")"

    if [[ "$current_target" == "$SOURCE" ]]; then
      log "~/.zshrc already points to $SOURCE"
      return
    fi

    fail "~/.zshrc already points elsewhere: $current_target"
  fi

  if [[ -e "$TARGET" ]]; then
    fail "~/.zshrc already exists and is not a symlink"
  fi

  ln -s "$SOURCE" "$TARGET"
  log "Linked ~/.zshrc -> $SOURCE"
}

main "$@"
