cmake_minimum_required(VERSION 3.16)
project(spell_wasm C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXECUTABLE_SUFFIX ".js")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/deploy/spell)

include(ExternalProject)

message( "Fetch and patch Hunspell" )
get_filename_component(ROOT_DIR "./" ABSOLUTE)
ExternalProject_Add(hunspell
    GIT_REPOSITORY https://github.com/hunspell/hunspell.git
    GIT_TAG v1.7.2
    GIT_SHALLOW TRUE
    SOURCE_DIR hunspell

    CONFIGURE_COMMAND ""
    BUILD_COMMAND bash ${ROOT_DIR}/nc-build.sh hunspell
    INSTALL_COMMAND ""
)

# ---- Sources ----
set(HUNSPELL_SRC
    hunspell/src/hunspell/affentry.cxx
    hunspell/src/hunspell/affixmgr.cxx
    hunspell/src/hunspell/csutil.cxx
    hunspell/src/hunspell/hashmgr.cxx
    hunspell/src/hunspell/hunspell.cxx
    hunspell/src/hunspell/hunzip.cxx
    hunspell/src/hunspell/phonet.cxx
    hunspell/src/hunspell/replist.cxx
    hunspell/src/hunspell/suggestmgr.cxx
)

set_source_files_properties(${HUNSPELL_SRC} PROPERTIES GENERATED TRUE)

set(WRAPPER_SRC
    wasm/src/filemgr_wrapper_new.cxx
    wasm/src/base.cpp
)

add_executable(spell
    ${HUNSPELL_SRC}
    ${WRAPPER_SRC}
)
add_dependencies(spell hunspell)

# ---- Includes ----
target_include_directories(spell PRIVATE
    hunspell/src/hunspell
    wasm/src
)

# ---- Defines ----
target_compile_definitions(spell PRIVATE
    WIN32
    NDEBUG
    HUNSPELL_STATIC
    BUILDING_LIBHUNSPELL
    HUNSPELL_WASM_MODULE
)

# ---- Compile flags ----
target_compile_options(spell PRIVATE
    -O3
    -fno-exceptions
    #-fno-rtti
    -Wno-unused-command-line-argument
)

# ---- Linker flags ----
target_link_options(spell PRIVATE
    "-sALLOW_MEMORY_GROWTH=1"
    "-sFILESYSTEM=0"
    "-sENVIRONMENT=web,worker"
    "-sEXPORTED_FUNCTIONS=['_malloc','_free','_Spellchecker_Malloc','_Spellchecker_Free','_Spellchecker_Create','_Spellchecker_Destroy','_Spellchecker_AddDictionary','_Spellchecker_RemoveDicrionary','_Spellchecker_Load','_Spellchecker_Spell','_Spellchecker_Suggest','_Spellchecker_RemoveEngine','_Spellchecker_TotalAllocatedMemory']"
    "-sEXPORTED_RUNTIME_METHODS=['ccall','cwrap']"
)