# Shell functions.

# Side-by-side diff of two zip archives by their file listings.
zipdiff() {
    diff -W200 -y --suppress-common-lines \
        <(unzip -vql "$1" | sort -k8) \
        <(unzip -vql "$2" | sort -k8)
}

# Collapse a PEM file to a single line with literal \n escapes, for stuffing
# a certificate into an environment variable or JSON field.
minify-pem() {
    awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' "$1"
}

# nnn wrapper that cds the shell to nnn's last directory on quit.
n() {
    if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # NNN_TMPFILE is a fixed contract with nnn; do not rename it.
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
