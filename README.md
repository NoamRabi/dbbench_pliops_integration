# dbbench_pliops_integration
This repository contain the files and information customer will need to integrate between pliops software and dbbench

1. Clone rocks db version 6.2 (tag - origin/6.2.fb)
2. Store_lib should be located in this relative path - ../roadster_sw/host/storelib/store_lib_expo.h
3. Go to the ubuntu library
4. copy the following files instead of existing files
   A. CmakeLists.txt (to main folder)
   B. thirdparty.inc (to main folder)
   C. db_bench_tool.cc (to tools folder)
   D. Findstorelib.cmake (to cmake/modules folder
   E. delete CmakeCache.txt
5. run cmake
6. db bench is ready.
