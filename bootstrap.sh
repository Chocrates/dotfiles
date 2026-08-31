#!/usr/bin/env bash
#
# Bare-metal bootstrap for a new machine or container.
#
# Installs the minimum needed to run chezmoi, then hands everything else over
# to `chezmoi init --apply`, which pulls this repo, installs packages via the
# .chezmoiscripts/ hooks, and installs toolchains via mise.
#
#   curl -fsSL https://raw.githubusercontent.com/Chocrates/dotfiles/main/bootstrap.sh | bash
#
set -euo pipefail

GITHUB_USER="${GITHUB_USER:-Chocrates}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"

log() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }

# --- prerequisites -----------------------------------------------------------
if command -v apt-get >/dev/null 2>&1; then
    log "installing bootstrap prerequisites via apt"
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
        ca-certificates curl git gnupg2 unzip zsh
elif [ "$(uname -s)" = "Darwin" ]; then
    # Compilers first: Homebrew and several formulae need them, and the
    # installer is a GUI prompt that cannot be scripted around.
    if ! xcode-select -p >/dev/null 2>&1; then
        log "installing Xcode Command Line Tools (accept the GUI prompt, then rerun)"
        xcode-select --install || true
        exit 1
    fi

    if ! command -v brew >/dev/null 2>&1; then
        for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
            [ -x "$candidate" ] && eval "$("$candidate" shellenv)" && break
        done
    fi

    if ! command -v brew >/dev/null 2>&1; then
        log "installing Homebrew"
        NONINTERACTIVE=1 /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
            [ -x "$candidate" ] && eval "$("$candidate" shellenv)" && break
        done
    fi

    log "installing bootstrap prerequisites via brew"
    brew install curl git gnupg zsh
else
    log "no supported package manager found; assuming curl/git/zsh are present"
fi

mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

# --- chezmoi -----------------------------------------------------------------
if ! command -v chezmoi >/dev/null 2>&1; then
    log "installing chezmoi into $BIN_DIR"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
fi

# --- default shell -----------------------------------------------------------
# Skipped when zsh is already the login shell, and when running as a user whose
# shell we cannot change (most CI and container images).
if [ "$(basename "${SHELL:-}")" != "zsh" ] && command -v zsh >/dev/null 2>&1; then
    log "setting zsh as the login shell for $(whoami)"
    sudo chsh -s "$(command -v zsh)" "$(whoami)" || \
        log "could not change login shell; do it manually with: chsh -s $(command -v zsh)"
fi

# --- everything else ---------------------------------------------------------
log "applying dotfiles"
chezmoi init --apply "$GITHUB_USER"

log "done. Start a new shell, or: exec zsh"
