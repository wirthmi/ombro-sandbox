cmake_minimum_required( VERSION 3.5.0 )


# project definition and global settings

project( OmbroSandbox )

if( NOT CMAKE_BUILD_TYPE )
  set( CMAKE_BUILD_TYPE Release )
endif( )

message( "-- Consider using: -DCMAKE_BUILD_TYPE=<type>" )
message( "-- Current build type: ${CMAKE_BUILD_TYPE}" )


# target definition and properties

file( GLOB_RECURSE sources src/*.cpp )

add_executable( ombro-sandbox ${sources} )

set_property( TARGET ombro-sandbox PROPERTY CXX_STANDARD 11 )
set_property( TARGET ombro-sandbox PROPERTY CXX_STANDARD_REQUIRED ON )

target_include_directories(
  ombro-sandbox
  PUBLIC include/
)


# target dependencies

find_package( Boost 1.58.0 REQUIRED )

if( find_dependencies )

  message( "-- Consider using: -DCMAKE_PREFIX_PATH=<path>" )

  find_package( aToolbox QUIET CONFIG )
  find_package( OmbroBase QUIET CONFIG )
  find_package( OmbroIO QUIET CONFIG )

else( )

  message( "-- Consider using: -Dfind_dependencies=ON" )

  add_subdirectory( lib/atb/ )
  add_dependencies( ombro-sandbox atb )

  add_subdirectory( lib/ombro_base/ )
  add_dependencies( ombro_base atb )
  add_dependencies( ombro-sandbox ombro_base )

  add_subdirectory( lib/ombro_io/ )
  add_dependencies( ombro_io atb ombro_base )
  add_dependencies( ombro-sandbox ombro_io )

endif( )

target_link_libraries(
  ombro-sandbox
  ${Boost_LIBRARIES}
  atb
  ombro_base
  ombro_io
)


# target installation instructions

install(
  TARGETS ombro-sandbox
  ARCHIVE DESTINATION lib/
  LIBRARY DESTINATION lib/
  RUNTIME DESTINATION bin/
)
