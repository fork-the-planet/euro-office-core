#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

$SCRIPT_DIR/../../3rdParty/nc-build.sh $SCRIPT_DIR/../../3rdParty/openssl-wasm
