cmake_minimum_required(VERSION 3.16)
project(spell)

set(CMAKE_CXX_STANDARD 17)

# -------------------------------------------------
# Ensure Emscripten toolchain
# -------------------------------------------------
if(NOT EMSCRIPTEN)
    message(FATAL_ERROR "This project must be built with Emscripten (use emcmake).")
endif()


# -------------------------------------------------
# Pre / Post build scripts
# -------------------------------------------------
add_custom_target(${PROJECT_NAME}_run_before ALL
    COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/nc-build.sh "${CMAKE_CURRENT_SOURCE_DIR}/hunspell"
)

# -------------------------------------------------
# Source files (compile_files_array)
# -------------------------------------------------
set(HUNSPELL_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/affentry.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/affixmgr.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/csutil.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/hashmgr.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/hunspell.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/hunzip.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/phonet.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/replist.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell/suggestmgr.cxx
)

set_source_files_properties(${HUNSPELL_SRC} PROPERTIES GENERATED TRUE)

# -------------------------------------------------
# Wrapper Source files
# -------------------------------------------------
set(WRAPPER_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/wasm/src/filemgr_wrapper_new.cxx
    ${CMAKE_CURRENT_SOURCE_DIR}/wasm/src/base.cpp
)

# -------------------------------------------------
# Executable (WASM module)
# -------------------------------------------------
add_executable(${PROJECT_NAME}
    ${HUNSPELL_SRC}
    ${WRAPPER_SRC}
)
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_run_before)

# -------------------------------------------------
# Output folder
# -------------------------------------------------
set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${EO_CORE_OUTPUT_DIR}/${PROJECT_NAME}
)

# -------------------------------------------------
# Include directories
# -------------------------------------------------
target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/hunspell/src/hunspell
    ${CMAKE_CURRENT_SOURCE_DIR}/wasm/src
)

# -------------------------------------------------
# Defines
# -------------------------------------------------
target_compile_definitions(${PROJECT_NAME} PRIVATE
    WIN32
    NDEBUG
    HUNSPELL_STATIC
    BUILDING_LIBHUNSPELL
    HUNSPELL_WASM_MODULE
)

# -------------------------------------------------
# Compiler flags (non -s ones)
# -------------------------------------------------
target_compile_options(${PROJECT_NAME} PRIVATE
    -O3
    -fno-exceptions
    #-fno-rtti
    -Wno-unused-command-line-argument
)

# -------------------------------------------------
# Linker flags (Emscripten -s options)
# -------------------------------------------------
target_link_options(${PROJECT_NAME} PRIVATE
    "-sALLOW_MEMORY_GROWTH=1"
    "-sFILESYSTEM=0"
    "-sENVIRONMENT=web,worker"
    "-sEXPORTED_FUNCTIONS=['_malloc','_free','_Spellchecker_Malloc','_Spellchecker_Free','_Spellchecker_Create','_Spellchecker_Destroy','_Spellchecker_AddDictionary','_Spellchecker_RemoveDicrionary','_Spellchecker_Load','_Spellchecker_Spell','_Spellchecker_Suggest','_Spellchecker_RemoveEngine','_Spellchecker_TotalAllocatedMemory']"
    "-sEXPORTED_RUNTIME_METHODS=['ccall','cwrap']"
    "--pre-js ${CMAKE_CURRENT_SOURCE_DIR}/wasm/js/spell.js"
)