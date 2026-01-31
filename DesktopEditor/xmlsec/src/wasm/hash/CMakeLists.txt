cmake_minimum_required(VERSION 3.16)
project(engine_wasm C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXECUTABLE_SUFFIX ".js")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/deploy)


include(ExternalProject)

message( "Fetch and build OpenSSL with Emscripten" )
set(OPENSSL_ROOT "../3rdParty")
get_filename_component(OPENSSL_ROOT_ABS "${OPENSSL_ROOT}" ABSOLUTE)
set(OPENSSL_3RDPARTY_DIR "${OPENSSL_ROOT_ABS}/openssl-wasm")
set(OPENSSL_INSTALL_DIR "${OPENSSL_ROOT_ABS}/openssl")
ExternalProject_Add(openssl
    GIT_REPOSITORY https://github.com/openssl/openssl.git
    GIT_TAG OpenSSL_1_1_1f
    GIT_SHALLOW TRUE
    SOURCE_DIR ${OPENSSL_3RDPARTY_DIR}

    CONFIGURE_COMMAND ""
    BUILD_COMMAND bash ${OPENSSL_ROOT_ABS}/nc-build.sh "${OPENSSL_3RDPARTY_DIR}" "${OPENSSL_INSTALL_DIR}"
    INSTALL_COMMAND ""
)


# ---- Sources (from JSON) ----
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

add_executable(engine ${SRC} main.cpp)
add_dependencies(engine openssl)


target_include_directories(engine PRIVATE
    .
    ${OPENSSL_3RDPARTY_DIR}/include
)

target_link_libraries(engine PRIVATE
    ${OPENSSL_3RDPARTY_DIR}/libcrypto.a
    ${OPENSSL_3RDPARTY_DIR}/libssl.a
)

# ---- Defines ----
target_compile_definitions(engine PRIVATE
    WIN32
    NDEBUG
    OPENSSL_MD2_ENABLED
)

# ---- Compile flags ----
target_compile_options(engine PRIVATE
    -O3
    -fno-exceptions
    -fno-rtti
    -Wno-unused-command-line-argument
)

# ---- Emscripten link flags ----
target_link_options(engine PRIVATE
    "-sALLOW_MEMORY_GROWTH=1"
    "-sFILESYSTEM=0"
    "-sENVIRONMENT=worker"
    "-sTOTAL_STACK=1MB"
    "-sINITIAL_MEMORY=2MB"
    "-sEXPORTED_FUNCTIONS=['_malloc','_free','_hash','_hash2']"
    "-sEXPORTED_RUNTIME_METHODS=['ccall','cwrap']"
)