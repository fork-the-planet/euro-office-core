cmake_minimum_required(VERSION 3.10)
project(zlib_wasm)

set(CMAKE_CXX_STANDARD 17)

#add_subdirectory(
#    ../../UnicodeConverter 
#    ${CMAKE_BINARY_DIR}/UnicodeConverter
#)

#target_link_libraries(zlib PRIVATE UnicodeConverter)

# Output folder
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/deploy)

# ---- Source groups from JSON ----

set(SRC
    # ---- minizip ----
    ../src/zlib-1.2.11/contrib/minizip/unzip.c
    ../src/zlib-1.2.11/contrib/minizip/ioapi.c
    ../src/zlib-1.2.11/contrib/minizip/zip.c
    ../src/zlib-1.2.11/contrib/minizip/ioapibuf.c


    # ---- zlib core ----
    ../src/zlib-1.2.11/inflate.c
    ../src/zlib-1.2.11/zutil.c
    ../src/zlib-1.2.11/adler32.c
    ../src/zlib-1.2.11/crc32.c
    ../src/zlib-1.2.11/inftrees.c
    ../src/zlib-1.2.11/inffast.c
    ../src/zlib-1.2.11/deflate.c
    ../src/zlib-1.2.11/trees.c
    ../src/zlib-1.2.11/uncompr.c
    ../src/zlib-1.2.11/compress.c

    # ---- project glue ----
    ./../src/ZipBuffer.cpp
    ./wasm/src/base.cpp
    ./../src/zlib_addon.c

    # ---- raster ----
    ../../DesktopEditor/graphics/Image.cpp
    ../../DesktopEditor/graphics/Matrix.cpp
    ../../DesktopEditor/graphics/GraphicsPath.cpp
    ../../DesktopEditor/raster/BgraFrame.cpp
    ../../DesktopEditor/raster/ImageFileFormatChecker.cpp

    ../../DesktopEditor/graphics/pro/js/qt/raster/pro_Fonts_empty.cpp
    ../../DesktopEditor/graphics/pro/js/qt/raster/pro_Graphics_empty.cpp
    ../../DesktopEditor/graphics/pro/js/qt/raster/raster.cpp

    # ---- ci ----
    ../../DesktopEditor/cximage/CxImage/ximaenc.cpp
    ../../DesktopEditor/cximage/CxImage/ximaexif.cpp
    ../../DesktopEditor/cximage/CxImage/ximage.cpp
    ../../DesktopEditor/cximage/CxImage/ximainfo.cpp
    ../../DesktopEditor/cximage/CxImage/ximajpg.cpp
    ../../DesktopEditor/cximage/CxImage/ximalpha.cpp
    ../../DesktopEditor/cximage/CxImage/ximapal.cpp
    ../../DesktopEditor/cximage/CxImage/ximasel.cpp
    ../../DesktopEditor/cximage/CxImage/xmemfile.cpp
    ../../DesktopEditor/cximage/CxImage/ximapng.cpp
    ../../DesktopEditor/cximage/CxImage/ximabmp.cpp
    ../../DesktopEditor/cximage/CxImage/ximatran.cpp
    ../../DesktopEditor/cximage/CxImage/ximatif.cpp
    ../../DesktopEditor/cximage/CxImage/tif_xfile.cpp
    ../../DesktopEditor/cximage/CxImage/ximajas.cpp
    ../../DesktopEditor/cximage/CxImage/ximagif.cpp
    ../../DesktopEditor/cximage/CxImage/ximaico.cpp
    ../../DesktopEditor/cximage/CxImage/ximatga.cpp
    ../../DesktopEditor/cximage/CxImage/ximapcx.cpp
    ../../DesktopEditor/cximage/CxImage/ximawbmp.cpp
    ../../DesktopEditor/cximage/CxImage/ximamng.cpp
    ../../DesktopEditor/cximage/CxImage/ximapsd.cpp
    ../../DesktopEditor/cximage/CxImage/ximaska.cpp
    ../../DesktopEditor/cximage/CxImage/ximaraw.cpp

    # ---- jpeg ----
    ../../DesktopEditor/cximage/jpeg/jerror.c
    ../../DesktopEditor/cximage/jpeg/jdmarker.c
    ../../DesktopEditor/cximage/jpeg/jdapimin.c
    ../../DesktopEditor/cximage/jpeg/jdmaster.c
    ../../DesktopEditor/cximage/jpeg/jdapistd.c
    ../../DesktopEditor/cximage/jpeg/jcomapi.c
    ../../DesktopEditor/cximage/jpeg/jutils.c
    ../../DesktopEditor/cximage/jpeg/jdinput.c
    ../../DesktopEditor/cximage/jpeg/jdmainct.c
    ../../DesktopEditor/cximage/jpeg/jmemmgr.c
    ../../DesktopEditor/cximage/jpeg/jquant1.c
    ../../DesktopEditor/cximage/jpeg/jquant2.c
    ../../DesktopEditor/cximage/jpeg/jdmerge.c
    ../../DesktopEditor/cximage/jpeg/jdcolor.c
    ../../DesktopEditor/cximage/jpeg/jdsample.c
    ../../DesktopEditor/cximage/jpeg/jdpostct.c
    ../../DesktopEditor/cximage/jpeg/jddctmgr.c
    ../../DesktopEditor/cximage/jpeg/jdarith.c
    ../../DesktopEditor/cximage/jpeg/jdhuff.c
    ../../DesktopEditor/cximage/jpeg/jdcoefct.c
    ../../DesktopEditor/cximage/jpeg/jmemnobs.c
    ../../DesktopEditor/cximage/jpeg/jidctint.c
    ../../DesktopEditor/cximage/jpeg/jidctfst.c
    ../../DesktopEditor/cximage/jpeg/jidctflt.c
    ../../DesktopEditor/cximage/jpeg/jaricom.c
    ../../DesktopEditor/cximage/jpeg/jcapimin.c
    ../../DesktopEditor/cximage/jpeg/jcparam.c
    ../../DesktopEditor/cximage/jpeg/jcapistd.c
    ../../DesktopEditor/cximage/jpeg/jcinit.c
    ../../DesktopEditor/cximage/jpeg/jcmaster.c
    ../../DesktopEditor/cximage/jpeg/jccolor.c
    ../../DesktopEditor/cximage/jpeg/jcmarker.c
    ../../DesktopEditor/cximage/jpeg/jcsample.c
    ../../DesktopEditor/cximage/jpeg/jcprepct.c
    ../../DesktopEditor/cximage/jpeg/jcdctmgr.c
    ../../DesktopEditor/cximage/jpeg/jcarith.c
    ../../DesktopEditor/cximage/jpeg/jchuff.c
    ../../DesktopEditor/cximage/jpeg/jccoefct.c
    ../../DesktopEditor/cximage/jpeg/jcmainct.c
    ../../DesktopEditor/cximage/jpeg/jfdctint.c
    ../../DesktopEditor/cximage/jpeg/jfdctfst.c
    ../../DesktopEditor/cximage/jpeg/jfdctflt.c

    # ---- png ----
    ../../DesktopEditor/cximage/png/pngread.c
    ../../DesktopEditor/cximage/png/pngmem.c
    ../../DesktopEditor/cximage/png/pngerror.c
    ../../DesktopEditor/cximage/png/png.c
    ../../DesktopEditor/cximage/png/pngrio.c
    ../../DesktopEditor/cximage/png/pngtrans.c
    ../../DesktopEditor/cximage/png/pngget.c
    ../../DesktopEditor/cximage/png/pngrutil.c
    ../../DesktopEditor/cximage/png/pngrtran.c
    ../../DesktopEditor/cximage/png/pngset.c
    ../../DesktopEditor/cximage/png/pngwrite.c
    ../../DesktopEditor/cximage/png/pngwio.c
    ../../DesktopEditor/cximage/png/pngwutil.c
    ../../DesktopEditor/cximage/png/pngwtran.c

    # ---- tiff ----
    ../../DesktopEditor/cximage/tiff/tif_close.c
    ../../DesktopEditor/cximage/tiff/tif_dir.c
    ../../DesktopEditor/cximage/tiff/tif_aux.c
    ../../DesktopEditor/cximage/tiff/tif_getimage.c
    ../../DesktopEditor/cximage/tiff/tif_strip.c
    ../../DesktopEditor/cximage/tiff/tif_open.c
    ../../DesktopEditor/cximage/tiff/tif_tile.c
    ../../DesktopEditor/cximage/tiff/tif_error.c
    ../../DesktopEditor/cximage/tiff/tif_read.c
    ../../DesktopEditor/cximage/tiff/tif_flush.c
    ../../DesktopEditor/cximage/tiff/tif_dirinfo.c
    ../../DesktopEditor/cximage/tiff/tif_compress.c
    ../../DesktopEditor/cximage/tiff/tif_warning.c
    ../../DesktopEditor/cximage/tiff/tif_swab.c
    ../../DesktopEditor/cximage/tiff/tif_color.c
    ../../DesktopEditor/cximage/tiff/tif_dirread.c
    ../../DesktopEditor/cximage/tiff/tif_write.c
    ../../DesktopEditor/cximage/tiff/tif_codec.c
    ../../DesktopEditor/cximage/tiff/tif_luv.c
    ../../DesktopEditor/cximage/tiff/tif_dirwrite.c
    ../../DesktopEditor/cximage/tiff/tif_dumpmode.c
    ../../DesktopEditor/cximage/tiff/tif_fax3.c
    ../../DesktopEditor/cximage/tiff/tif_ojpeg.c
    ../../DesktopEditor/cximage/tiff/tif_jpeg.c
    ../../DesktopEditor/cximage/tiff/tif_next.c
    ../../DesktopEditor/cximage/tiff/tif_thunder.c
    ../../DesktopEditor/cximage/tiff/tif_packbits.c
    ../../DesktopEditor/cximage/tiff/tif_lzw.c
    ../../DesktopEditor/cximage/tiff/tif_zip.c
    ../../DesktopEditor/cximage/tiff/tif_fax3sm.c
    ../../DesktopEditor/cximage/tiff/tif_predict.c

    # ---- Metafile ----
    ../../DesktopEditor/raster/Metafile/MetaFile.cpp
    ../../DesktopEditor/raster/Metafile/Common/CClip.cpp
    ../../DesktopEditor/raster/Metafile/Common/MetaFileTypes.cpp
    ../../DesktopEditor/raster/Metafile/Common/MetaFileUtils.cpp
    ../../DesktopEditor/raster/Metafile/Common/CPathConverter.cpp
    ../../DesktopEditor/raster/Metafile/Common/CPath.cpp
    ../../DesktopEditor/raster/PICT/PICFile.cpp

    # ---- Emf ----
    ../../DesktopEditor/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretator.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretatorArray.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretatorRender.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfInterpretator/CEmfInterpretatorSvg.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfParser/CEmfParser.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfParser/CEmfParserBase.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfParser/CEmfPlusParser.cpp
    #../../DesktopEditor/raster/Metafile/Emf/EmfClip.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfObjects.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfPlusObjects.cpp
    #../../DesktopEditor/raster/Metafile/Emf/EmfPath.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfPlayer.cpp
    ../../DesktopEditor/raster/Metafile/Emf/EmfFile.cpp

    # ---- wmf ----
    ../../DesktopEditor/raster/Metafile/Wmf/WmfInterpretator/CWmfInterpretatorSvg.cpp
    ../../DesktopEditor/raster/Metafile/Wmf/WmfInterpretator/CInterpretatorSvgBase.cpp
    ../../DesktopEditor/raster/Metafile/Wmf/WmfInterpretator/CWmfInterpretatorRender.cpp
    ../../DesktopEditor/raster/Metafile/Wmf/WmfInterpretator/cwmfinterpretator.cpp
    ../../DesktopEditor/raster/Metafile/Wmf/WmfParser/CWmfParser.cpp
    ../../DesktopEditor/raster/Metafile/Wmf/WmfParser/CWmfParserBase.cpp
    #../../DesktopEditor/raster/Metafile/Wmf/WmfClip.cpp
    ../../DesktopEditor/raster/Metafile/Wmf/WmfObjects.cpp
    ../../DesktopEditor/raster/Metafile/Wmf/WmfPlayer.cpp

    # ---- common ----
    ../../DesktopEditor/common/File.cpp
    ../../DesktopEditor/common/Base64.cpp
    ../../DesktopEditor/common/StringExt.cpp
    ../../DesktopEditor/common/StringBuilder.cpp
    ../../DesktopEditor/common/../xml/src/xmlwriter.cpp
    #../../DesktopEditor/common/../xml/src/xmllight.cpp

    # ---- agg ----
    ../../DesktopEditor/agg-2.4/src/agg_trans_affine.cpp
    ../../DesktopEditor/agg-2.4/src/agg_bezier_arc.cpp


    ### These are part of full build    
    # ---- jasper ----
    ../../DesktopEditor/cximage/jasper/base/jas_init.c
    ../../DesktopEditor/cximage/jasper/base/jas_stream.c
    ../../DesktopEditor/cximage/jasper/base/jas_malloc.c
    ../../DesktopEditor/cximage/jasper/base/jas_image.c
    ../../DesktopEditor/cximage/jasper/base/jas_cm.c
    ../../DesktopEditor/cximage/jasper/base/jas_seq.c
    ../../DesktopEditor/cximage/jasper/base/jas_string.c
    ../../DesktopEditor/cximage/jasper/base/jas_icc.c
    ../../DesktopEditor/cximage/jasper/base/jas_debug.c
    ../../DesktopEditor/cximage/jasper/base/jas_iccdata.c
    ../../DesktopEditor/cximage/jasper/base/jas_tvp.c
    ../../DesktopEditor/cximage/jasper/base/jas_version.c
    ../../DesktopEditor/cximage/jasper/mif/mif_cod.c
    ../../DesktopEditor/cximage/jasper/pnm/pnm_dec.c
    ../../DesktopEditor/cximage/jasper/pnm/pnm_enc.c
    ../../DesktopEditor/cximage/jasper/pnm/pnm_cod.c
    ../../DesktopEditor/cximage/jasper/bmp/bmp_dec.c
    ../../DesktopEditor/cximage/jasper/bmp/bmp_enc.c
    ../../DesktopEditor/cximage/jasper/bmp/bmp_cod.c
    ../../DesktopEditor/cximage/jasper/ras/ras_dec.c
    ../../DesktopEditor/cximage/jasper/ras/ras_enc.c
    ../../DesktopEditor/cximage/jasper/jp2/jp2_dec.c
    ../../DesktopEditor/cximage/jasper/jp2/jp2_enc.c
    ../../DesktopEditor/cximage/jasper/jp2/jp2_cod.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_cs.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_enc.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_dec.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_t1cod.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_math.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_util.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_tsfb.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_mct.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_t1enc.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_t1dec.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_bs.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_t2cod.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_t2enc.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_t2dec.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_tagtree.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_mqenc.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_mqdec.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_mqcod.c
    ../../DesktopEditor/cximage/jasper/jpc/jpc_qmfb.c
    ../../DesktopEditor/cximage/jasper/jpg/jpg_val.c
    ../../DesktopEditor/cximage/jasper/jpg/jpg_dummy.c
    ../../DesktopEditor/cximage/jasper/pgx/pgx_dec.c
    ../../DesktopEditor/cximage/jasper/pgx/pgx_enc.c

    # ---- jp2 ----
    ../../DesktopEditor/raster/Jp2/J2kFile.cpp
    ../../DesktopEditor/raster/Jp2/Reader.cpp

    # ---- mng ----
    ../../DesktopEditor/cximage/mng/libmng_hlapi.c
    ../../DesktopEditor/cximage/mng/libmng_callback_xs.c
    ../../DesktopEditor/cximage/mng/libmng_prop_xs.c
    ../../DesktopEditor/cximage/mng/libmng_object_prc.c
    ../../DesktopEditor/cximage/mng/libmng_zlib.c
    ../../DesktopEditor/cximage/mng/libmng_jpeg.c
    ../../DesktopEditor/cximage/mng/libmng_pixels.c
    ../../DesktopEditor/cximage/mng/libmng_read.c
    ../../DesktopEditor/cximage/mng/libmng_error.c
    ../../DesktopEditor/cximage/mng/libmng_display.c
    ../../DesktopEditor/cximage/mng/libmng_write.c
    ../../DesktopEditor/cximage/mng/libmng_chunk_io.c
    ../../DesktopEditor/cximage/mng/libmng_cms.c
    ../../DesktopEditor/cximage/mng/libmng_filter.c
    ../../DesktopEditor/cximage/mng/libmng_chunk_prc.c
    ../../DesktopEditor/cximage/mng/libmng_chunk_xs.c

    # ---- libpsd ----
    ../../DesktopEditor/cximage/libpsd/psd.c
    ../../DesktopEditor/cximage/libpsd/file_header.c
    ../../DesktopEditor/cximage/libpsd/color_mode.c
    ../../DesktopEditor/cximage/libpsd/image_resource.c
    ../../DesktopEditor/cximage/libpsd/blend.c
    ../../DesktopEditor/cximage/libpsd/layer_mask.c
    ../../DesktopEditor/cximage/libpsd/image_data.c
    ../../DesktopEditor/cximage/libpsd/stream.c
    ../../DesktopEditor/cximage/libpsd/psd_system.c
    ../../DesktopEditor/cximage/libpsd/color.c
    ../../DesktopEditor/cximage/libpsd/pattern_fill.c
    ../../DesktopEditor/cximage/libpsd/color_balance.c
    ../../DesktopEditor/cximage/libpsd/channel_image.c
    ../../DesktopEditor/cximage/libpsd/gradient_fill.c
    ../../DesktopEditor/cximage/libpsd/invert.c
    ../../DesktopEditor/cximage/libpsd/posterize.c
    ../../DesktopEditor/cximage/libpsd/brightness_contrast.c
    ../../DesktopEditor/cximage/libpsd/solid_color.c
    ../../DesktopEditor/cximage/libpsd/threshold.c
    ../../DesktopEditor/cximage/libpsd/effects.c
    ../../DesktopEditor/cximage/libpsd/selective_color.c
    ../../DesktopEditor/cximage/libpsd/channel_mixer.c
    ../../DesktopEditor/cximage/libpsd/photo_filter.c
    ../../DesktopEditor/cximage/libpsd/type_tool.c
    ../../DesktopEditor/cximage/libpsd/gradient_map.c
    ../../DesktopEditor/cximage/libpsd/hue_saturation.c
    ../../DesktopEditor/cximage/libpsd/levels.c
    ../../DesktopEditor/cximage/libpsd/curves.c
    ../../DesktopEditor/cximage/libpsd/pattern.c
    ../../DesktopEditor/cximage/libpsd/psd_zip.c
    ../../DesktopEditor/cximage/libpsd/descriptor.c
    ../../DesktopEditor/cximage/libpsd/drop_shadow.c
    ../../DesktopEditor/cximage/libpsd/inner_shadow.c
    ../../DesktopEditor/cximage/libpsd/color_overlay.c
    ../../DesktopEditor/cximage/libpsd/outer_glow.c
    ../../DesktopEditor/cximage/libpsd/inner_glow.c
    ../../DesktopEditor/cximage/libpsd/bevel_emboss.c
    ../../DesktopEditor/cximage/libpsd/satin.c
    ../../DesktopEditor/cximage/libpsd/gradient_overlay.c
    ../../DesktopEditor/cximage/libpsd/stroke.c
    ../../DesktopEditor/cximage/libpsd/pattern_overlay.c

    # ---- raw ----
    ../../DesktopEditor/cximage/raw/libdcr.c

    # ---- jbig ----
    ../../DesktopEditor/raster/JBig2/source/JBig2File.cpp
    ../../DesktopEditor/raster/JBig2/source/Encoder/jbig2enc.cpp
    ../../DesktopEditor/raster/JBig2/source/Encoder/jbig2arith.cpp
    ../../DesktopEditor/raster/JBig2/source/Encoder/jbig2sym.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pixconv.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/writefile.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/scale.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pix1.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pix2.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pix3.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pix4.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pix5.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/grayquant.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/grayquantlow.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/seedfill.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/jbclass.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pixabasic.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/numabasic.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/morphseq.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/binexpandlow.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/ptabasic.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/rop.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/colormap.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pngiostub.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/lepton_utils.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/scalelow.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/enhance.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/jpegio.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/jpegiostub.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/spixio.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/webpio.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/webpiostub.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/psio2.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/gifio.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/gifiostub.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pnmio.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/tiffio.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/tiffiostub.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/bmpio.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/binexpand.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/compare.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/boxbasic.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/conncomp.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pixafunc1.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/boxfunc1.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/ptafunc1.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/binreduce.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/seedfilllow.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/sel1.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/morphapp.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/correlscore.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/sarray.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/morph.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/roplow.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/fpix1.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/stack.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pixacc.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/pixarith.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/convolve.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/binreducelow.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/convolvelow.cpp
    ../../DesktopEditor/raster/JBig2/source/LeptonLib/arithlow.cpp

)

add_executable(zlib ${SRC})



# ---- Includes ----
target_include_directories(zlib PRIVATE
    ../src/zlib-1.2.11
    ../src
    ../../DesktopEditor/cximage/jasper/include
    ../../DesktopEditor/cximage/jpeg
    ../../DesktopEditor/cximage/png
    ../../DesktopEditor/xml/libxml2/include
    ../../DesktopEditor/agg-2.4/include
)

# Add library path
#target_link_directories(zlib PRIVATE 
#    ../../DesktopEditor/xml/libxml2
#)

# ---- Defines ----
target_compile_definitions(zlib PRIVATE
    __linux__ _LINUX UNIX _QT
    EXCLUDE_JPG_SUPPORT
    METAFILE_SUPPORT_WMF_EMF
    MNG_SUPPORT_DISPLAY
    MNG_SUPPORT_READ
    MNG_SUPPORT_WRITE
    MNG_ACCESS_CHUNKS
    MNG_STORE_CHUNKS
    MNG_ERROR_TELLTALE
    HAVE_UNISTD_H HAVE_FCNTL_H _ARM_ALIGN_
    CXIMAGE_DISABLE_SUPPORT_MNG
    CXIMAGE_DISABLE_SUPPORT_ADDITIONS
    IMAGE_CHECKER_DISABLE_XML
    _tcsnicmp=strncmp
    _lseek=lseek
    _getcwd=getcwd
    NO_CONSOLE_IO
    BUILD_ZLIB_AS_SOURCES
)

# ---- Compiler flags ----
target_compile_options(zlib PRIVATE
    -O3
    -Wno-unused-command-line-argument
    -Wno-register
)

# ---- Emscripten link flags ----
#[[
set_target_properties(zlib PROPERTIES LINK_FLAGS "
    -s ALLOW_MEMORY_GROWTH=1
    -s FILESYSTEM=0
    -s ENVIRONMENT=web,worker
    -s EXPORTED_FUNCTIONS=[
        '_malloc','_free',
        '_Zlib_Malloc','_Zlib_Free','_Zlib_Create','_Zlib_Open','_Zlib_Close',
        '_Zlib_AddFile','_Zlib_RemoveFile','_Zlib_GetPaths','_Zlib_GetFile','_Zlib_Save',
        '_Raster_DecodeFile','_Raster_GetDecodedBuffer','_Raster_GetHeight',
        '_Raster_GetWidth','_Raster_GetStride','_Raster_Destroy',
        '_Raster_EncodeImageData','_Raster_Encode','_Raster_GetEncodedBuffer',
        '_Raster_GetEncodedSize','_Raster_DestroyEncodedData','_Image_GetFormat'
    ]
    -s EXPORTED_RUNTIME_METHODS=['ccall','cwrap']
")
]]
target_link_options(zlib PRIVATE
    "-sALLOW_MEMORY_GROWTH=1"
    "-sFILESYSTEM=0"
    "-sENVIRONMENT=web,worker"
    "-sEXPORTED_FUNCTIONS=['_malloc','_free','_Zlib_Malloc','_Zlib_Free','_Zlib_Create','_Zlib_Open','_Zlib_Close','_Zlib_AddFile','_Zlib_RemoveFile','_Zlib_GetPaths','_Zlib_GetFile','_Zlib_Save','_Raster_DecodeFile','_Raster_GetDecodedBuffer','_Raster_GetHeight','_Raster_GetWidth','_Raster_GetStride','_Raster_Destroy','_Raster_EncodeImageData','_Raster_Encode','_Raster_GetEncodedBuffer','_Raster_GetEncodedSize','_Raster_DestroyEncodedData','_Image_GetFormat']"
    "-sEXPORTED_RUNTIME_METHODS=['ccall','cwrap']"
)