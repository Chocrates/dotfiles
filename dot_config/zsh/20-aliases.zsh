# Aliases.

# lsd is a drop-in ls with icons; fall back to plain ls when it is absent.
if (( $+commands[lsd] )); then
    alias ls='lsd'
    alias lt='ls --tree'
else
    alias ls='ls --color=auto'
fi
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'

(( $+commands[nvim] )) && alias vim='nvim'

alias nnn='nnn -e'

alias inflate='ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"'

# List every distinct extension of the binary files in a repo.
alias findbin='find . -type f -not -path "./.git/*" -exec perl -MFile::Basename -e '\''print (-T $_ ? "" : (fileparse ($_, qr/\.[^.]*/))[2] . "\n" ) for @ARGV'\'' {} + | sort | uniq'
