cmake_minimum_required(VERSION 3.20)
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
add_custom_target(run_before ALL
    COMMAND bash ${CMAKE_SOURCE_DIR}/nc-build.sh
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

# -------------------------------------------------
# Source files (compile_files_array)
# -------------------------------------------------
set(CORE_ROOT ${CMAKE_SOURCE_DIR}/../../../../../..)

set(SOURCES
    ${CORE_ROOT}/DesktopEditor/common/Base64.cpp
    ${CORE_ROOT}/DesktopEditor/common/File.cpp

    ${CORE_ROOT}/Common/3dParty/openssl/common/common_openssl.cpp

    ${CMAKE_SOURCE_DIR}/main.cpp
)

# -------------------------------------------------
# Executable (WASM module)
# -------------------------------------------------
add_executable(${PROJECT_NAME} ${SOURCES})
add_dependencies(${PROJECT_NAME} run_before)

# -------------------------------------------------
# Include directories
# -------------------------------------------------
target_include_directories(${PROJECT_NAME} PRIVATE
${CORE_ROOT}/DesktopEditor/xmlsec/src/wasm/3rdParty/openssl-wasm/include
${CORE_ROOT}/DesktopEditor/xmlsec/src/wasm/3rdParty/openssl-wasm
#emsdk/node/14.15.5_64bit/include/node/openssl/archs/linux-x86_64/no-asm/include
)

# -------------------------------------------------
# Defines
# -------------------------------------------------
target_compile_definitions(${PROJECT_NAME} PRIVATE
__linux__
_LINUX
DISABLE_XMLSEC
)

# -------------------------------------------------
# Compiler flags (non -s ones)
# -------------------------------------------------
target_compile_options(${PROJECT_NAME} PRIVATE
-O3
-Wno-unused-command-line-argument
)

# -------------------------------------------------
# Exported functions
# -------------------------------------------------
set(EXPORTED_FUNCS
"_malloc",
"_free",
"_Crypto_Malloc",
"_Crypto_Free",
"_Crypto_CreateKeys",
"_Crypto_Sign",
"_Crypto_ChangePassword"
)

#string(REPLACE ";" "," EXPORTED_FUNCS_STR "${EXPORTED_FUNCS}")

# -------------------------------------------------
# Linker flags (Emscripten -s options)
# -------------------------------------------------
target_link_options(${PROJECT_NAME} PRIVATE
-sALLOW_MEMORY_GROWTH=1
-sFILESYSTEM=0
-sENVIRONMENT=web
-sASSERTIONS
-sLLD_REPORT_UNDEFINED
-sWASM=1
-sEXPORTED_FUNCTIONS=[${EXPORTED_FUNCS_STR}]
--pre-js ${CMAKE_SOURCE_DIR}/engine_base.js
)

# -------------------------------------------------
# Link static OpenSSL crypto lib
# -------------------------------------------------
target_link_libraries(${PROJECT_NAME} PRIVATE
${CORE_ROOT}/DesktopEditor/xmlsec/src/wasm/3rdParty/openssl-wasm/libcrypto.a
)

# -------------------------------------------------
# Output settings
# -------------------------------------------------
set_target_properties(${PROJECT_NAME} PROPERTIES
RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/deploy
SUFFIX ".js"
)