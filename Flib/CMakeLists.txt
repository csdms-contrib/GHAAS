FILE(GLOB sources src/*.c)
add_library(F30 ${sources})
target_include_directories(F30 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
                                      ${CMAKE_CURRENT_SOURCE_DIR}/../CMlib/include)

install(
  TARGETS F30
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/ghaas
)
install(
  FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/include/Flib.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ghaas
)
