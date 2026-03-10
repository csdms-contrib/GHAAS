FILE(GLOB sources src/*.cpp)
add_library(DB30 ${sources})
target_include_directories(DB30 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include
                                       ${CMAKE_CURRENT_SOURCE_DIR}/../CMlib/include)

install(
  TARGETS DB30
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/ghaas
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/ghaas
)
install(
  FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/include/DB.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/include/DBif.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/include/DBtf.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ghaas
)
