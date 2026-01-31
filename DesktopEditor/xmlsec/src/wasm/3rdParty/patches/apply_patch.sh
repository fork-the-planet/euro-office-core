#!/usr/bin/env bash
set -e

TARGET_FILE="$1"
PATCH_FILE="$2"

OLD=$(awk '/^<<<<<<<$/{flag=1;next}/^=======$/{flag=0}flag' "$PATCH_FILE")
NEW=$(awk '/^=======$/{flag=1;next}/^>>>>>>>$/{flag=0}flag' "$PATCH_FILE")

env OLD_CODE="$OLD" NEW_CODE="$NEW" \
perl -i -0777 -pe 's/\Q$ENV{OLD_CODE}\E/$ENV{NEW_CODE}/g' $TARGET_FILE