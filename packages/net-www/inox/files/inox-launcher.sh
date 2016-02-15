#!/bin/bash

# Chromium launcher

# Authors: Fabien Tassin <fta@sofaraway.org>
# Source: Debian, Gentoo
# License: GPLv2 or later

if [ -f /etc/chromium/default ] ; then
  . /etc/chromium/default
fi

# Prefer user defined CHROMIUM_USER_FLAGS (fron env) over system
# default CHROMIUM_FLAGS (from /etc/chromium/default)
CHROMIUM_FLAGS=${CHROMIUM_USER_FLAGS:-"$CHROMIUM_FLAGS"}

# For the Default Browser detection to work, we need to give access
# to xdg-settings. Also set CHROME_WRAPPER in case xdg-settings is
# not able to do anything useful
export CHROME_WRAPPER="`readlink -f "$0"`"

PROGDIR="`dirname "$CHROME_WRAPPER"`"
case ":$PATH:" in
  *:$PROGDIR:*)
    # $PATH already contains $PROGDIR
    ;;
  *)
    # Append $PROGDIR to $PATH
    export PATH="$PATH:$PROGDIR"
    ;;
esac

# Set the .desktop file name
export CHROME_DESKTOP=chromium-browser.desktop

exec -a "chromium-browser" "$PROGDIR/chrome" --extra-plugin-dir=/opt/netscape/plugins $CHROMIUM_FLAGS "$@"