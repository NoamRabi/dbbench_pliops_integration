# dbbench_pliops_integration
This repository contain the files and information needed to integrate pliops PSP KV and rocksdb.


Motivation
==========
This repository target is to modify the exist rocksdb repository in order to have the ability to estimate the pliops KV product,
after performing those installation steps you could run db bench tool with flag called pliops_disc, if its value will be '0' the 
tool will run with rocksdb as usual, if its value will be '1' the tool will run using pliops KV software and hardware without 
using rocksdb.


Pliops KV product
=================


Modify files and compilation
============================
1. Clone rocks db version 6.2 (tag - origin/6.2.fb)
2. Install pliops SW deilivery package (13.6.1 or higher).
3. Go to the repoistory ubuntu library.
4. Copy the following files instead of existing files:
   A. CmakeLists.txt (to main folder)
   B. thirdparty.inc (to main folder)
   C. db_bench_tool.cc (to tools folder)
   D. Findstorelib.cmake (to cmake/modules folder
   E. delete CmakeCache.txt
5. Find the path of the following files (part of pliops delivery):
   A. store_lib_expo.h
   B. storlib.so
6. Update the following files with the paths from the previos scetion
   A. Findstorelib.cmake - need to update the location store_lib_expo.h & storelib.so
   B. db_bench_tool.cc = need to update the location of store_lib_expo.h 
7. Delete cmake cache - CmakeCache.txt
8. Run cmake (cmake .)
9. Run make (make -j )

db bench is ready !!!


Running examples
================

