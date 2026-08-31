#!/usr/bin/env bash
# tpm itself is cloned by .chezmoiexternal.toml; this installs the plugins
# tmux.conf declares.
set -euo pipefail

[ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ] || exit 0
"$HOME/.tmux/plugins/tpm/bin/install_plugins" || echo "tpm install_plugins failed (no tmux server?); run prefix+I inside tmux"
