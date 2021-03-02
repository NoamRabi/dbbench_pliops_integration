# Find storelib
# Find the storelib library and includes
#
# STORELIB_INCLUDE_DIR - where to find store_lib_expo.h and etc.
# STORELIB_LIBRARIES - List of libraries when using storelib.
# STORELIB_FOUND - True if storelib found.

find_path(STORELIB_INCLUDE_DIR
  NAMES store_lib_expo.h
  HINTS /home/pliops/workspace/roadster_sw/host/storelib)

find_library(STORELIB_LIBRARIES
  NAMES storelib
  HINTS /home/pliops/workspace/roadster_sw/host/storelib/release/lib)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(storelib DEFAULT_MSG STORELIB_LIBRARIES STORELIB_INCLUDE_DIR)

mark_as_advanced(
  STORELIB_LIBRARIES
  STORELIB_INCLUDE_DIR)
