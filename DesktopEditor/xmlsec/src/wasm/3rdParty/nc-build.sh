#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

OPENSSL_DIR="$1"

if [ ! -d "$OPENSSL_DIR" ]; then
  git clone --depth=1 --branch OpenSSL_1_1_1f https://github.com/openssl/openssl.git $OPENSSL_DIR
fi

# patch1
$SCRIPT_DIR/patches/apply_patch.sh \
  $OPENSSL_DIR/crypto/rand/rand_lib.c \
  $SCRIPT_DIR/patches/openssl1.patch

source /opt/emsdk/emsdk_env.sh

cd $OPENSSL_DIR
emconfigure ./config no-shared no-asm no-threads no-dso
sed -i 's|^CROSS_COMPILE.*$|CROSS_COMPILE=|g' Makefile
emmake make build_generated libcrypto.a libssl.a
#emmake make install_sw

# patch2 
$SCRIPT_DIR/patches/apply_patch.sh \
  $OPENSSL_DIR/include/openssl/opensslconf.h \
  $SCRIPT_DIR/patches/openssl2.patch