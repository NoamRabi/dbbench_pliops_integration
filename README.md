# dbbench_pliops_integration
This repository contain the files and information customer will need to integrate between pliops software and dbbench

1. Clone rocks db version 6.2 (tag - origin/6.2.fb)
2. Go to the ubuntu library
3. copy the following files instead of existing files
   A. CmakeLists.txt (to main folder)
   B. thirdparty.inc (to main folder)
   C. db_bench_tool.cc (to tools folder)
   D. Findstorelib.cmake (to cmake/modules folder
   E. delete CmakeCache.txt
4. Need to allocate the following two files at fixed library
   A. store_lib_expo.h
   B. storlib.so
5. Need to update the following files with the paths from the previos scetion
   A. Findstorelib.cmake - need to update the location store_lib_expo.h & storelib.so
   B. db_bench_tool.cc = need to update the location of store_lib_expo.h 
6. clean cmake cache - CmakeCache.txt
7. run cmake
8. db bench is ready.
