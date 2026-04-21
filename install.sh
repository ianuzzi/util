#!/usr/bin/env bash
set -euo pipefail

UTIL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASHRC="$HOME/.bashrc"
BASH_PROFILE="$HOME/.bash_profile"
PROFILE="$HOME/.profile"

UTIL_SOURCE_LINE="[ -f \"$UTIL_DIR/cfg/load.sh\" ] && . \"$UTIL_DIR/cfg/load.sh\""
BASHRC_SOURCE_LINE='[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"'

add_line_if_missing() {
    local file="$1"
    local line="$2"

    touch "$file"

    if ! grep -Fqx "$line" "$file"; then
        printf '\n%s\n' "$line" >> "$file"
        echo "Updated: $file"
    else
        echo "Already configured: $file"
    fi
}

echo "Installing util from: $UTIL_DIR"

# Ensure .bashrc loads util
add_line_if_missing "$BASHRC" "$UTIL_SOURCE_LINE"

# Ensure login shell loads .bashrc
if [ -f "$BASH_PROFILE" ]; then
    add_line_if_missing "$BASH_PROFILE" "$BASHRC_SOURCE_LINE"
else
    add_line_if_missing "$PROFILE" "$BASHRC_SOURCE_LINE"
fi

echo
echo "Install complete."
echo "Run: source ~/.bashrc"
