#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"
ZSH_DEFER_DIR="${HOME}/zsh-defer"
ZSH_DEFER_REPO="https://github.com/romkatv/zsh-defer.git"

log() {
  printf '==> %s\n' "$1"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

ensure_homebrew() {
  if need_cmd brew; then
    return
  fi

  cat <<'EOF'
Homebrew is required to install the tracked dotfiles dependencies.

Install it first
EOF
  exit 1
}

ensure_brew_bundle() {
  if brew bundle check --file="$BREWFILE" >/dev/null 2>&1; then
    log "Homebrew dependencies already installed"
  else
    log "Installing Homebrew dependencies from Brewfile"
    brew bundle --file="$BREWFILE"
  fi
}

ensure_zsh_defer() {
  if [[ -d "$ZSH_DEFER_DIR/.git" ]]; then
    log "Updating zsh-defer"
    git -C "$ZSH_DEFER_DIR" pull --ff-only
    return
  fi

  if [[ -d "$ZSH_DEFER_DIR" ]]; then
    log "zsh-defer directory exists but is not a git repo: $ZSH_DEFER_DIR"
    return 1
  fi

  log "Cloning zsh-defer"
  git clone "$ZSH_DEFER_REPO" "$ZSH_DEFER_DIR"
}

main() {
  ensure_homebrew
  ensure_brew_bundle
  ensure_zsh_defer
  log "Dependencies are ready"
}

main "$@"
