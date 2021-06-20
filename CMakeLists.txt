cmake_minimum_required(VERSION 3.2)
project(sixel VERSION 0.0.2 LANGUAGES C)
include(FindPkgConfig)

add_library(sixelutils SHARED sixelutils.c)

pkg_check_modules(SIXEL REQUIRED libsixel)
if (SIXEL_FOUND)
    mark_as_advanced(SIXEL_LIBRARY SIXEL_INCLUDE_DIR)

    find_path(SIXEL_INCLUDE_DIRS
        NAMES sixel.h
        HINTS ${SIXEL_INCLUDEDIR} ${SIXEL_INCLUDE_DIRS})
    target_include_directories(sixelutils PRIVATE ${SIXEL_INCLUDE_DIRS})

    find_library(SIXEL_LIBRARY
        NAMES sixel
        HINTS ${SIXEL_LIBDIR} ${SIXEL_LIBRARY_PATH})
    target_link_libraries(sixelutils PRIVATE ${SIXEL_LIBRARY})
endif ()

add_custom_target(build ALL
    COMMAND idris2 --build sixel.ipkg
    DEPENDS sixelutils
    VERBATIM)

install(CODE "execute_process(COMMAND idris2 --install sixel.ipkg)")
execute_process(
    COMMAND         idris2 --libdir
    OUTPUT_VARIABLE IDRIS2_LIBDIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)
install(TARGETS sixelutils DESTINATION "${IDRIS2_LIBDIR}/sixel-0.0.2/lib/")
