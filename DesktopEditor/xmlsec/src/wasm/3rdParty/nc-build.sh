#!/bin/bash
set -e

OPENSSL_DIR="$1"

if [ ! -d "$OPENSSL_DIR" ]; then
  git clone --depth=1 --branch OpenSSL_1_1_1f https://github.com/openssl/openssl.git $OPENSSL_DIR
fi

cd $OPENSSL_DIR

# patch1
../patches/apply_patch.sh \
  crypto/rand/rand_lib.c \
  ../patches/openssl1.patch

source /opt/emsdk/emsdk_env.sh

emconfigure ./config no-shared no-asm no-threads no-dso
sed -i 's|^CROSS_COMPILE.*$|CROSS_COMPILE=|g' Makefile
emmake make build_generated libcrypto.a libssl.a
#emmake make install_sw

# patch2 
../patches/apply_patch.sh \
  include/openssl/opensslconf.h \
  ../patches/openssl2.patch