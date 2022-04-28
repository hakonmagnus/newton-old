if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif ()

option(NT_BUILD_TESTS           "Build the unit tests"                  ON)
option(NT_BUILD_DOCS            "Build the Doxygen documentation"       OFF)
option(NT_BUILD_EXAMPLES        "Build the examples"                    OFF)
option(NT_BUILD_BENCHMARKS      "Build the performance benchmarks"      OFF)
option(NT_WARNINGS_ARE_ERRORS   "Treat warnings as errors"              OFF)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
