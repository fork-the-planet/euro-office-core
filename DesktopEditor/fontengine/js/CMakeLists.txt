cmake_minimum_required(VERSION 3.20)
project(fonts)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

# -------------------------------------------------
# Must use Emscripten
# -------------------------------------------------
if(NOT EMSCRIPTEN)
    message(FATAL_ERROR "Build with Emscripten: emcmake cmake ...")
endif()

set(CORE_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../../..)
set(DESKTOP_ROOT ${CORE_ROOT}/DesktopEditor)

# -------------------------------------------------
# Pre/Post scripts
# -------------------------------------------------
add_custom_target(${PROJECT_NAME}_run_before ALL
    COMMAND bash ${CORE_ROOT}/Common/3dParty/brotli/nc-fetch.sh ${CORE_ROOT}/Common/3dParty/brotli/brotli
    COMMAND bash ${CORE_ROOT}/Common/3dParty/harfbuzz/nc-fetch.sh ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz
    COMMAND bash ${CORE_ROOT}/Common/3dParty/hyphen/nc-fetch.sh ${DESKTOP_ROOT}/fontengine/hyphen
    COMMAND bash ${DESKTOP_ROOT}/graphics/pro/js/nc-build.sh
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# -------------------------------------------------
# Sources (from compile_files_array)
# Pattern: <folder>/<file>
# -------------------------------------------------

set(SOURCES

    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/common/constants.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/common/context.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/common/dictionary.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/common/platform.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/common/shared_dictionary.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/common/transform.c

    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/dec/bit_reader.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/dec/decode.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/dec/huffman.c
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/dec/state.c

    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftdebug.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/autofit/autofit.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/bdf/bdf.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/cff/cff.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftbase.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftbitmap.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftfstype.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftgasp.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/cache/ftcache.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftglyph.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/gzip/ftgzip.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftinit.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/lzw/ftlzw.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftstroke.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftsystem.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/smooth/smooth.cpp
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftbbox.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftbdf.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftcid.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftmm.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftpfr.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftsynth.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/fttype1.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftwinfnt.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftgxval.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftotval.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/base/ftpatent.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/pcf/pcf.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/pfr/pfr.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/psaux/psaux.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/pshinter/pshinter.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/psnames/psmodule.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/raster/raster.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/sfnt/sfnt.cpp
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/truetype/truetype.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/type1/type1.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/cid/type1cid.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/type42/type42.c
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/src/winfonts/winfnt.c
    ${DESKTOP_ROOT}/graphics/GraphicsPath.cpp

    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-aat-layout.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-aat-map.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-blob.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-buffer-serialize.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-buffer-verify.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-buffer.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-cairo-utils.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-cairo.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-common.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-coretext.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-directwrite.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-draw.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-face-builder.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-face.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-fallback-shape.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-font.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ft.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-gdi.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-glib.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-gobject-structs.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-graphite2.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-icu.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-map.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-number.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-cff1-table.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-cff2-table.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-color.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-face.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-font.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-layout.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-map.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-math.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-meta.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-metrics.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-name.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shape-fallback.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shape-normalize.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shape.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-arabic.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-default.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-hangul.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-hebrew.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-indic-table.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-indic.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-khmer.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-myanmar.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-syllabic.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-thai.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-use.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-shaper-vowel-constraints.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-tag.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ot-var.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-outline.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-paint-extents.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-paint.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-set.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-shape-plan.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-shape.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-shaper.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-static.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-style.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset-cff-common.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset-cff1.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset-cff2.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset-input.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset-instancer-solver.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset-plan.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset-repacker.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-subset.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-ucd.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-unicode.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-uniscribe.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-wasm-api.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/hb-wasm-shape.cc
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src/graph/gsubgpos-context.cc

    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/adler32.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/crc32.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/deflate.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/infback.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/inffast.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/inflate.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/inftrees.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/trees.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/zutil.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/compress.c

    ${CMAKE_CURRENT_SOURCE_DIR}/cpp/text.cpp

    ${DESKTOP_ROOT}/graphics/pro/js/wasm/src/lib/wasm_jmp.cpp

    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/contrib/minizip/unzip.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/contrib/minizip/ioapi.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/contrib/minizip/zip.c
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11/contrib/minizip/ioapibuf.c

    ${CORE_ROOT}/OfficeUtils/js/../src/ZipBuffer.cpp
    ${CORE_ROOT}/OfficeUtils/js/wasm/src/base.cpp
    ${CORE_ROOT}/OfficeUtils/js/../src/zlib_addon.c

    ${DESKTOP_ROOT}/graphics/Image.cpp
    ${DESKTOP_ROOT}/raster/BgraFrame.cpp
    ${DESKTOP_ROOT}/raster/ImageFileFormatChecker.cpp
    ${DESKTOP_ROOT}/graphics/Matrix.cpp

    ${DESKTOP_ROOT}/agg-2.4/src/agg_trans_affine.cpp
    ${DESKTOP_ROOT}/agg-2.4/src/agg_bezier_arc.cpp

    ${DESKTOP_ROOT}/raster/PICT/PICFile.cpp
    #${DESKTOP_ROOT}/raster/PICT/pic.cpp

    ${DESKTOP_ROOT}/graphics/pro/js/qt/raster/pro_Fonts_empty.cpp
    ${DESKTOP_ROOT}/graphics/pro/js/qt/raster/pro_Graphics_empty.cpp
    ${DESKTOP_ROOT}/graphics/pro/js/qt/raster/raster.cpp

    ${DESKTOP_ROOT}/cximage/CxImage/ximaenc.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximaexif.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximage.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximainfo.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximajpg.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximalpha.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximapal.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximasel.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/xmemfile.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximapng.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximabmp.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximatran.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximatif.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/tif_xfile.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximajas.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximagif.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximaico.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximatga.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximapcx.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximawbmp.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximamng.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximapsd.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximaska.cpp
    ${DESKTOP_ROOT}/cximage/CxImage/ximaraw.cpp

    ${DESKTOP_ROOT}/cximage/jpeg/jerror.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdmarker.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdapimin.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdmaster.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdapistd.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcomapi.c
    ${DESKTOP_ROOT}/cximage/jpeg/jutils.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdinput.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdmainct.c
    ${DESKTOP_ROOT}/cximage/jpeg/jmemmgr.c
    ${DESKTOP_ROOT}/cximage/jpeg/jquant1.c
    ${DESKTOP_ROOT}/cximage/jpeg/jquant2.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdmerge.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdcolor.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdsample.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdpostct.c
    ${DESKTOP_ROOT}/cximage/jpeg/jddctmgr.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdarith.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdhuff.c
    ${DESKTOP_ROOT}/cximage/jpeg/jdcoefct.c
    ${DESKTOP_ROOT}/cximage/jpeg/jmemnobs.c
    ${DESKTOP_ROOT}/cximage/jpeg/jidctint.c
    ${DESKTOP_ROOT}/cximage/jpeg/jidctfst.c
    ${DESKTOP_ROOT}/cximage/jpeg/jidctflt.c
    ${DESKTOP_ROOT}/cximage/jpeg/jaricom.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcapimin.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcparam.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcapistd.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcinit.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcmaster.c
    ${DESKTOP_ROOT}/cximage/jpeg/jccolor.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcmarker.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcsample.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcprepct.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcdctmgr.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcarith.c
    ${DESKTOP_ROOT}/cximage/jpeg/jchuff.c
    ${DESKTOP_ROOT}/cximage/jpeg/jccoefct.c
    ${DESKTOP_ROOT}/cximage/jpeg/jcmainct.c
    ${DESKTOP_ROOT}/cximage/jpeg/jfdctint.c
    ${DESKTOP_ROOT}/cximage/jpeg/jfdctfst.c
    ${DESKTOP_ROOT}/cximage/jpeg/jfdctflt.c

    ${DESKTOP_ROOT}/cximage/png/pngread.c
    ${DESKTOP_ROOT}/cximage/png/pngmem.c
    ${DESKTOP_ROOT}/cximage/png/pngerror.c
    ${DESKTOP_ROOT}/cximage/png/png.c
    ${DESKTOP_ROOT}/cximage/png/pngrio.c
    ${DESKTOP_ROOT}/cximage/png/pngtrans.c
    ${DESKTOP_ROOT}/cximage/png/pngget.c
    ${DESKTOP_ROOT}/cximage/png/pngrutil.c
    ${DESKTOP_ROOT}/cximage/png/pngrtran.c
    ${DESKTOP_ROOT}/cximage/png/pngset.c
    ${DESKTOP_ROOT}/cximage/png/pngwrite.c
    ${DESKTOP_ROOT}/cximage/png/pngwio.c
    ${DESKTOP_ROOT}/cximage/png/pngwutil.c
    ${DESKTOP_ROOT}/cximage/png/pngwtran.c

    ${DESKTOP_ROOT}/cximage/tiff/tif_close.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_dir.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_aux.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_getimage.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_strip.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_open.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_tile.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_error.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_read.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_flush.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_dirinfo.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_compress.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_warning.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_swab.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_color.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_dirread.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_write.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_codec.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_luv.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_dirwrite.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_dumpmode.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_fax3.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_ojpeg.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_jpeg.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_next.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_thunder.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_packbits.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_lzw.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_zip.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_fax3sm.c
    ${DESKTOP_ROOT}/cximage/tiff/tif_predict.c

    ${DESKTOP_ROOT}/raster/Metafile/MetaFile.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Common/MetaFileTypes.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Common/MetaFileUtils.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Common/CPathConverter.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Common/CPath.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Common/CClip.cpp

    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretator.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretatorArray.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretatorRender.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretatorSvg.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfParser/CEmfParser.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfParser/CEmfParserBase.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfParser/CEmfPlusParser.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfObjects.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfPlusObjects.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfPlayer.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Emf/EmfFile.cpp

    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfInterpretator/CInterpretatorSvgBase.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfInterpretator/CWmfInterpretatorSvg.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfInterpretator/CWmfInterpretatorRender.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfInterpretator/cwmfinterpretator.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfParser/CWmfParser.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfParser/CWmfParserBase.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfObjects.cpp
    ${DESKTOP_ROOT}/raster/Metafile/Wmf/WmfPlayer.cpp

    ${DESKTOP_ROOT}/common/File.cpp
    ${DESKTOP_ROOT}/common/Base64.cpp
    ${DESKTOP_ROOT}/common/StringExt.cpp
    ${DESKTOP_ROOT}/common/StringBuilder.cpp
    ${DESKTOP_ROOT}/xml/src/xmlwriter.cpp

    ${DESKTOP_ROOT}/fontengine/TextHyphen.cpp

    ${CORE_ROOT}/Common/3dParty/hyphen/js/src/hyphen.cpp
)

set_source_files_properties(${SOURCES} PROPERTIES GENERATED TRUE)

# -------------------------------------------------
# Executable (WASM module)
# -------------------------------------------------
add_executable(${PROJECT_NAME} ${SOURCES})
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_run_before)

# -------------------------------------------------
# Include paths
# -------------------------------------------------
target_include_directories(${PROJECT_NAME} PRIVATE
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/include
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/include/freetype
    ${DESKTOP_ROOT}/graphics/pro/js/freetype-2.10.4/include/freetype/internal
    ${DESKTOP_ROOT}/graphics/pro/js/wasm/src/lib
    ${CORE_ROOT}/Common/3dParty/harfbuzz/harfbuzz/src
    ${CORE_ROOT}/Common/3dParty/brotli/brotli/c/include
    ${CORE_ROOT}/OfficeUtils/src
    ${CORE_ROOT}/OfficeUtils/src/zlib-1.2.11
    ${DESKTOP_ROOT}/cximage/jasper/include
    ${DESKTOP_ROOT}/cximage/jpeg
    ${DESKTOP_ROOT}/cximage/png
    ${DESKTOP_ROOT}/agg-2.4/include
)

# -------------------------------------------------
# Defines
# -------------------------------------------------
target_compile_definitions(${PROJECT_NAME} PRIVATE
__linux__ _LINUX UNIX _QT
NDEBUG _LIB _CRT_SECURE_NO_WARNINGS
FT2_BUILD_LIBRARY HAVE_FREETYPE FT_CONFIG_OPTION_SYSTEM_ZLIB
GRAPHICS_NO_USE_DYNAMIC_LIBRARY
HYPHEN_ENGINE_DISABLE_FILESYSTEM
METAFILE_DISABLE_FILESYSTEM
HAVE_UNISTD_H HAVE_FCNTL_H _ARM_ALIGN_
METAFILE_SUPPORT_WMF_EMF
CXIMAGE_DISABLE_SUPPORT_MNG CXIMAGE_DISABLE_SUPPORT_ADDITIONS
_tcsnicmp=strncmp _lseek=lseek _getcwd=getcwd
NO_CONSOLE_IO BUILD_ZLIB_AS_SOURCES IMAGE_CHECKER_DISABLE_XML
FT_CONFIG_OPTION_USE_BROTLI
BUILDING_WASM_MODULE
)

# -------------------------------------------------
# Compile flags
# -------------------------------------------------
target_compile_options(${PROJECT_NAME} PRIVATE
-O3
-fexceptions
-Wno-unused-command-line-argument
-Wno-register
)

# -------------------------------------------------
# Exported functions
# -------------------------------------------------
set(EXPORTED_FUNCS
    _malloc
    _free
    _ASC_FT_Malloc
    _ASC_FT_Free
    _ASC_FT_Init
    _ASC_FT_Done_FreeType
    _ASC_FT_Set_TrueType_HintProp
    _ASC_FT_Open_Face
    _ASC_FT_Done_Face
    _ASC_FT_SetCMapForCharCode
    _ASC_FT_GetFaceInfo
    _ASC_FT_GetFaceMaxAdvanceX
    _ASC_FT_GetKerningX
    _ASC_FT_Set_Transform
    _ASC_FT_Set_Char_Size
    _ASC_FT_Load_Glyph
    _ASC_FT_Glyph_Get_CBox
    _ASC_FT_Get_Glyph_Measure_Params
    _ASC_FT_Get_Glyph_Render_Params
    _ASC_FT_Get_Glyph_Render_Buffer
    _ASC_HB_LanguageFromString
    _ASC_HB_ShapeText
    _ASC_HB_FontFree
    _hyphenCreateApplication
    _hyphenDestroyApplication
    _hyphenLoadDictionary
    _hyphenCheckDictionary
    _hyphenWord
    _Zlib_Malloc
    _Zlib_Free
    _Zlib_Create
    _Zlib_Open
    _Zlib_Close
    _Zlib_AddFile
    _Zlib_RemoveFile
    _Zlib_GetPaths
    _Zlib_GetFile
    _Zlib_Save
    _Raster_DecodeFile
    _Raster_GetDecodedBuffer
    _Raster_GetHeight
    _Raster_GetWidth
    _Raster_GetStride
    _Raster_Destroy
    _Raster_EncodeImageData
    _Raster_Encode
    _Raster_GetEncodedBuffer
    _Raster_GetEncodedSize
    _Raster_DestroyEncodedData
    _Image_GetFormat
)

#string(REPLACE ";" "," EXPORTED_FUNCS_STR "${EXPORTED_FUNCS}")
list(JOIN EXPORTED_FUNCS "," EXPORTED_FUNCS_STR)
# -------------------------------------------------
# Linker flags (Emscripten)
# -------------------------------------------------
target_link_options(${PROJECT_NAME} PRIVATE
-sALLOW_MEMORY_GROWTH=1
-sFILESYSTEM=0
-sENVIRONMENT=web
-sLLD_REPORT_UNDEFINED
-sWASM=1
-sEXPORTED_FUNCTIONS=[${EXPORTED_FUNCS_STR}]
-sEXPORTED_RUNTIME_METHODS=HEAP8,HEAPU8,HEAP32
-sLEGACY_VM_SUPPORT=1
"SHELL:--pre-js ${CMAKE_CURRENT_SOURCE_DIR}/engine/module_pre.js"
"SHELL:--pre-js ${CORE_ROOT}/Common/js/string_utf8.js"
"SHELL:--post-js ${CORE_ROOT}/Common/js/desktop_fetch_new.js"
"SHELL:--post-js ${CMAKE_CURRENT_SOURCE_DIR}/engine/module_post.js"
)

# -------------------------------------------------
# Output
# -------------------------------------------------
set_target_properties(${PROJECT_NAME} PROPERTIES
RUNTIME_OUTPUT_DIRECTORY ${EO_CORE_OUTPUT_DIR}/libfont/engine
SUFFIX ".js"
)

add_custom_target(${PROJECT_NAME}_copy_extra_files ALL
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_SOURCE_DIR}/module.js"
        "$<TARGET_FILE_DIR:${PROJECT_NAME}>/../engine.js"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_SOURCE_DIR}/engine/module_native.js"
        "$<TARGET_FILE_DIR:${PROJECT_NAME}>/fonts_native.js"
    COMMENT "Copying extra files to output"
    VERBATIM
)