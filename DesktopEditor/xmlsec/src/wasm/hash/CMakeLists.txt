cmake_minimum_required(VERSION 3.16)
project(engine)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

# -------------------------------------------------
# Ensure Emscripten toolchain
# -------------------------------------------------
if(NOT EMSCRIPTEN)
    message(FATAL_ERROR "This project must be built with Emscripten (use emcmake).")
endif()


# -------------------------------------------------
# Pre / Post build scripts
# -------------------------------------------------
set(OPENSSL_ROOT "../3rdParty")
get_filename_component(OPENSSL_ROOT_ABS "${OPENSSL_ROOT}" ABSOLUTE)
set(OPENSSL_3RDPARTY_DIR "${OPENSSL_ROOT_ABS}/openssl-wasm")
add_custom_target(${PROJECT_NAME}_run_before ALL
    COMMAND bash ${OPENSSL_ROOT_ABS}/nc-build.sh "${OPENSSL_3RDPARTY_DIR}"
)


# -------------------------------------------------
# Source files (compile_files_array)
# -------------------------------------------------

set(CORE_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../../../../..)

set(SRC
    ${OPENSSL_3RDPARTY_DIR}/crypto/sha/keccak1600.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/sha/sha1_one.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/sha/sha1dgst.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/sha/sha256.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/sha/sha512.c

    ${OPENSSL_3RDPARTY_DIR}/crypto/md2/md2_dgst.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/md2/md2_one.c

    ${OPENSSL_3RDPARTY_DIR}/crypto/md4/md4_dgst.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/md4/md4_one.c

    ${OPENSSL_3RDPARTY_DIR}/crypto/md5/md5_dgst.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/md5/md5_one.c

    ${OPENSSL_3RDPARTY_DIR}/crypto/ripemd/rmd_dgst.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/ripemd/rmd_one.c

    ${OPENSSL_3RDPARTY_DIR}/crypto/whrlpool/wp_block.c
    ${OPENSSL_3RDPARTY_DIR}/crypto/whrlpool/wp_dgst.c

    ${OPENSSL_3RDPARTY_DIR}/crypto/mem_clr.c
)

set_source_files_properties(${SRC} PROPERTIES GENERATED TRUE)

# -------------------------------------------------
# Executable (WASM module)
# -------------------------------------------------
add_executable(${PROJECT_NAME} ${SRC} ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_run_before)

# -------------------------------------------------
# Output settings
# -------------------------------------------------
set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${EO_CORE_OUTPUT_DIR}/hash/hash
    SUFFIX ".js"
)

# -------------------------------------------------
# Include directories
# -------------------------------------------------
target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${OPENSSL_3RDPARTY_DIR}/include
)

# -------------------------------------------------
# link libraries
# -------------------------------------------------
target_link_libraries(${PROJECT_NAME} PRIVATE
    ${OPENSSL_3RDPARTY_DIR}/libcrypto.a
    ${OPENSSL_3RDPARTY_DIR}/libssl.a
)

# -------------------------------------------------
# Defines
# -------------------------------------------------
target_compile_definitions(${PROJECT_NAME} PRIVATE
    WIN32
    NDEBUG
    OPENSSL_MD2_ENABLED
)

# -------------------------------------------------
# Compiler flags (non -s ones)
# -------------------------------------------------
target_compile_options(${PROJECT_NAME} PRIVATE
    -O3
    -fno-exceptions
    -fno-rtti
    -Wno-unused-command-line-argument
)

# -------------------------------------------------
# Linker flags (Emscripten -s options)
# -------------------------------------------------
target_link_options(${PROJECT_NAME} PRIVATE
    "-sALLOW_MEMORY_GROWTH=1"
    "-sFILESYSTEM=0"
    "-sENVIRONMENT=worker"
    "-sTOTAL_STACK=1MB"
    "-sINITIAL_MEMORY=2MB"
    "-sEXPORTED_FUNCTIONS=['_malloc','_free','_hash','_hash2']"
    "-sEXPORTED_RUNTIME_METHODS=['HEAPU8']"
    "-sLEGACY_VM_SUPPORT=1"
    "SHELL:--pre-js ${CORE_ROOT}/../sdkjs/common/stringserialize.js"
    "SHELL:--pre-js ${CMAKE_CURRENT_SOURCE_DIR}/hash_base_pre.js"
    "SHELL:--pre-js ${CORE_ROOT}/Common/js/string_utf8.js"
    "SHELL:--post-js ${CORE_ROOT}/Common/js/desktop_fetch_new.js"
    "SHELL:--post-js ${CMAKE_CURRENT_SOURCE_DIR}/hash_base_post.js"
)