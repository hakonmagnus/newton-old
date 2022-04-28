set(NEWTON_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/NtApplication.cpp
)

set(NEWTON_INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}/include/newton/newton.h
)

if (BUILD_SHARED_LIBS)
    add_library(newton SHARED ${NEWTON_SOURCES})
else ()
    add_library(newton STATIC ${NEWTON_SOURCES})
endif ()
