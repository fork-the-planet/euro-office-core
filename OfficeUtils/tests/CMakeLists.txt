cmake_minimum_required(VERSION 3.10)

project(officeutils_test)

set(CORE_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}/../..")

include(${CORE_ROOT_DIR}/common.cmake)

# Dependencies (mirror ADD_DEPENDENCY(kernel, UnicodeConverter) in tests.pro).
if(NOT TARGET kernel)
    add_subdirectory(${CORE_ROOT_DIR}/Common kernel)
endif()
if(NOT TARGET UnicodeConverter)
    add_subdirectory(${CORE_ROOT_DIR}/UnicodeConverter UnicodeConverter)
endif()

# main.cpp resolves its fixtures relative to the *process* (binary) directory,
# not the CTest working directory:
#   zipDirectory   = <binary dir>/../zip
#   unzipDirectory = <binary dir>/../unzip   (created at run time)
#   tempDirectory  = <binary dir>/../temp    (created at run time)
# So the committed zip/ fixtures must be staged one level above the binary, and
# that parent must be writable (it is, it lives under the build tree).
add_core_gtest(
    NAME    officeutils_test
    SOURCES main.cpp
    LIBS    kernel UnicodeConverter
    GTEST_MAIN
    WORKING_DIRECTORY "$<TARGET_FILE_DIR:officeutils_test>"
)

# Stage the committed zip/ fixtures next to where the test expects them
# (the parent of the binary directory).
add_custom_command(TARGET officeutils_test POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${CMAKE_CURRENT_SOURCE_DIR}/zip"
            "$<TARGET_FILE_DIR:officeutils_test>/../zip"
    COMMENT "Staging officeutils_test fixtures"
)
