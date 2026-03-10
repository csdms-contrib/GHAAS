FILE(GLOB sources src/*.cpp)
add_library(RG30 ${sources})
target_include_directories(RG30 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
                                       ${CMAKE_CURRENT_SOURCE_DIR}/../DBlib/include
                                       ${CMAKE_CURRENT_SOURCE_DIR}/../CMlib/include
                                       ${CMAKE_CURRENT_SOURCE_DIR}/../MFlib/include)

install(
  TARGETS RG30
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/ghaas
)
install(
  FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/include/RG.hpp
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ghaas
)
