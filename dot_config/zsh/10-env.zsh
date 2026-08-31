# PATH and core environment.

# Deduplicate PATH entries automatically.
typeset -U path fpath

# Only add directories that actually exist, so a fresh machine gets a clean
# PATH instead of a pile of dead entries.
_path_prepend() { [[ -d "$1" ]] && path=("$1" $path) }
_path_append()  { [[ -d "$1" ]] && path=($path "$1") }

# Homebrew, if present. Apple Silicon uses /opt/homebrew, Intel /usr/local.
# shellenv sets PATH, MANPATH, INFOPATH and HOMEBREW_* in one go, so nothing
# below needs to hardcode a prefix.
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x $_brew ]]; then
        eval "$("$_brew" shellenv)"
        break
    fi
done
unset _brew

# GNU coreutils from Homebrew install g-prefixed; put the real names first so
# scripts written against GNU behaviour work.
if [[ -d /opt/homebrew/opt/coreutils/libexec/gnubin ]]; then
    _path_prepend /opt/homebrew/opt/coreutils/libexec/gnubin
elif [[ -d /usr/local/opt/coreutils/libexec/gnubin ]]; then
    _path_prepend /usr/local/opt/coreutils/libexec/gnubin
fi

_path_append "$HOME/bin"
_path_append "$HOME/.local/bin"
_path_append "$HOME/.cargo/bin"

_path_prepend "$HOME/.opencode/bin"
_path_prepend "$HOME/.rd/bin"            # Rancher Desktop

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# nnn
export NNN_BMS='w:~/workspace'
export NNN_PLUG='t:treeview'

# `foo *` with no match should pass the glob through, not abort the command.
unsetopt nomatch
