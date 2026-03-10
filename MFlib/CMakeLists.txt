FILE(GLOB sources src/*.c)
add_library(MF30 ${sources})
target_include_directories(MF30 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
                                       ${CMAKE_CURRENT_SOURCE_DIR}/../CMlib/include)

install(
  TARGETS MF30
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/ghaas
)
install(
  FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/include/MF.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ghaas
)
