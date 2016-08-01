#!/bin/bash
set -e

# In production, let's auto-upgrade all themes.
# The base Ghost image will copy themes from the
# image /content/themes folder on startup, but only
# if they don't already exist.
if [ "$GHOST_REDEPLOY_THEMES" = "true" ]; then
  baseDir="$GHOST_SOURCE/content"
  for dir in "$baseDir"/themes/*/; do
    rm -rf "$GHOST_CONTENT/${dir#$baseDir/}"
  done
fi

# We also want our configuration to be overwritten with
# any new values baked into the image.  Removing src/config.js
# forces any
rm -f "$GHOST_SOURCE"/config.js
cp -f "$GHOST_SOURCE"/config.override.js "$GHOST_CONTENT"/config.js

exec "/entrypoint.sh" "$@"
