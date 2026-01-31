#!/bin/bash
set -e

HUNSPELL_DIR="$1"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

if [ ! -d "$HUNSPELL_DIR" ]; then
  git clone --depth=1 --branch v1.7.2 https://github.com/hunspell/hunspell.git $HUNSPELL_DIR
fi

./patch/apply_patch.sh \
  $SCRIPT_DIR/hunspell/src/hunspell/filemgr.hxx \
  $SCRIPT_DIR/patch/hunspell1.patch

./patch/apply_patch.sh \
  $SCRIPT_DIR/hunspell/src/hunspell/filemgr.hxx \
  $SCRIPT_DIR/patch/hunspell2.patch

./patch/apply_patch.sh \
  $SCRIPT_DIR/hunspell/src/hunspell/csutil.cxx \
  $SCRIPT_DIR/patch/hunspell3.patch

./patch/apply_patch.sh \
  $SCRIPT_DIR/hunspell/src/hunspell/atypes.hxx \
  $SCRIPT_DIR/patch/hunspell4.patch
