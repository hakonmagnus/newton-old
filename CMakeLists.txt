cmake_minimum_required(VERSION 3.10)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
include(cmake/Custom.cmake)

set_policy(CMP0054 NEW)
set_policy(CMP0042 NEW)
set_policy(CMP0063 NEW)
set_policy(CMP0077 NEW)

project(Newton
    VERSION 1.0.0
    LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Enable C++ standard
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Includes
include(CompilerCheck)
include(Options)
include(CompileOptions)
include(PrintInfo)

# Configuration

if (BUILD_SHARED_LIBS)
    set(NT_HEADER_SHARED_LIBS "#define NT_SHARED_LIBS")
else ()
    set(NT_HEADER_SHARED_LIBS "")
endif ()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config/config.h.in ${CMAKE_BINARY_DIR}/config/config.h @ONLY)

# Subdirectories
add_subdirectory(newton)
add_subdirectory(ntp)

if (NT_BUILD_EXAMPLES)
    add_subdirectory(examples)
endif ()

if (NT_BUILD_BENCHMARKS)
    add_subdirectory(benchmarks)
endif ()

# Static analyzers and linters
include(ClangTools)
include(Cppcheck)

# Testing
if (NT_BUILD_TESTS)
    enable_testing()
    include(GoogleTest)
    add_subdirectory(tests)
endif ()

# Documentation
if (NT_BUILD_DOCS)
    find_package(Doxygen)

    if (DOXYGEN_FOUND)
        set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in)
        set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

        configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

        add_custom_target(doc_doxygen ALL
            COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            COMMENT "Generating API documentation with Doxygen"
            VERBATIM)
    else ()
        message(WARNING "Doxygen needs to be installed to generate the Doxygen documentation.")
    endif ()
endif ()
