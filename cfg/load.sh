#!/usr/bin/env bash

# Resolve util directory relative to this file
UTIL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load all cfg/*.sh (except this file)
for file in "$UTIL_DIR"/cfg/*.sh; do
    [ -f "$file" ] || continue
    [ "$(basename "$file")" = "load.sh" ] && continue
    . "$file"
done

# Load aliases if present
if [ -d "$UTIL_DIR/aliases" ]; then
    for file in "$UTIL_DIR"/aliases/*.sh; do
        [ -f "$file" ] || continue
        . "$file"
    done
fi

# Add bin to PATH if not already there
case ":$PATH:" in
    *":$UTIL_DIR/bin:"*) ;;
    *) export PATH="$UTIL_DIR/bin:$PATH" ;;
esac
