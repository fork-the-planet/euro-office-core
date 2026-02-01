#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

$SCRIPT_DIR/../../../../Common/3dParty/icu/nc-build.sh $SCRIPT_DIR/icu $SCRIPT_DIR/icu  74 2 1
$SCRIPT_DIR/../../../../Common/3dParty/openssl/nc-build.sh $SCRIPT_DIR/../../../../Common/3dParty/openssl/openssl $SCRIPT_DIR/../../../../Common/3dParty/openssl/build 1

cp -r ../../../xml xml

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/xml/libxml2/libxml.h \
  $SCRIPT_DIR/wasm/patches/xml1.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/xml/libxml2/xmlIO.c \
  $SCRIPT_DIR/wasm/patches/xml1.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/xml/src/xmllight_private.h \
  $SCRIPT_DIR/wasm/patches/xml2.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/xml/include/xmlutils.h \
  $SCRIPT_DIR/wasm/patches/xml2.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/xml/src/xmllight_private.h \
  $SCRIPT_DIR/wasm/patches/xml3.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/xml/libxml2/globals.c \
  $SCRIPT_DIR/wasm/patches/xml4.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/xml/libxml2/globals.c \
  $SCRIPT_DIR/wasm/patches/xml5.patch

cp -r ../../../freetype-2.10.4 ./freetype-2.10.4

# smooth
cp ./freetype-2.10.4/src/smooth/ftgrays.c ./freetype-2.10.4/src/smooth/ftgrays.cpp
$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/smooth/ftgrays.cpp \
  $SCRIPT_DIR/wasm/patches/ftgrays1.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/smooth/ftgrays.cpp \
  $SCRIPT_DIR/wasm/patches/ftgrays2.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/smooth/ftgrays.cpp \
  $SCRIPT_DIR/wasm/patches/ftgrays3.patch

cp ./freetype-2.10.4/src/smooth/smooth.c ./freetype-2.10.4/src/smooth/smooth.cpp
$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/smooth/smooth.cpp \
  $SCRIPT_DIR/wasm/patches/smooth.patch

# ftobjs
$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/base/ftobjs.c \
  $SCRIPT_DIR/wasm/patches/ftobjs1.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/base/ftobjs.c \
  $SCRIPT_DIR/wasm/patches/ftobjs2.patch

# ttcmap
cp ./freetype-2.10.4/src/sfnt/ttcmap.c ./freetype-2.10.4/src/sfnt/ttcmap.cpp
$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/sfnt/ttcmap.cpp \
  $SCRIPT_DIR/wasm/patches/ttcmap.patch

cp ./freetype-2.10.4/src/sfnt/sfnt.c ./freetype-2.10.4/src/sfnt/sfnt.cpp
$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/src/sfnt/sfnt.cpp \
  $SCRIPT_DIR/wasm/patches/sfnt.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/freetype-2.10.4/builds/unix/ftsystem.c \
  $SCRIPT_DIR/wasm/patches/ftsystem.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/icu/icu/source/common/udata.cpp \
  $SCRIPT_DIR/wasm/patches/external1.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/../../../../DesktopEditor/cximage/png/pnglibconf.h \
  $SCRIPT_DIR/wasm/patches/external2.patch

$SCRIPT_DIR/wasm/patches/apply_patch.sh \
  $SCRIPT_DIR/../../../../Common/3dParty/openssl/openssl/crypto/sha/sha512.c \
  $SCRIPT_DIR/wasm/patches/external3.patch