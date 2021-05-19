# dbbench_pliops_integration
This repository contain the files and information needed to integrate pliops PSP KV and rocksdb.


Motivation
==========
This repository target is to modify the exist rocksdb repository in order to have the ability to estimate the pliops KV product,
after performing those installation steps you could run db bench tool with flag called pliops_disc, if its value will be '0' the 
tool will run with rocksdb as usual, if its value will be '1' the tool will run using pliops KV software and hardware without 
using rocksdb.


Pliops KV product description
=============================
Pliops KV is an HW accelrator that improve the performance and capacity of SSD discs, << need more info here >>



Modify files and compilation
============================
1. Clone rocks db version 6.2 (branch - origin/6.2.fb)
    1. _git clone https://github.com/facebook/rocksdb.git_
    2. _git checkout origin/6.2.fb _
2. Install pliops deilivery package (1.16.0.0 or higher).
3. Install compression libraries if needed.
   1. Ubuntu: _sudo apt-get install zlib1g-dev liblz4-dev_
   2. Centos: _sudo yum install zlib zlib-devel lz4-devel_
5. Copy the following files from this repository instead of existing files:
   1. CMakeLists.txt (to main folder)
   2. thirdparty.inc (to main folder)
   3. db_bench_tool.cc (to tools folder)
   4. Findstorelib.cmake (to cmake/modules folder
6. Find the path of the following files (part of pliops delivery):
   1. store_lib_expo.h
   2. storlib.so
7. Update the following files with the paths from the previos scetion
   1. Findstorelib.cmake - need to update the location of store_lib_expo.h [line 10] & storelib.so [line 14]
   2. db_bench_tool.cc = need to update the location of store_lib_expo.h [line 78]
8. Delete cmake cache if exist - CMakeCache.txt
9. Create build directory - mkdir build
10. Enter the build directory - cd build
11. Run cmake (cmake ..)
12. Run make (make -j )

db bench is ready !!!


Known issues
============
1. On non-pliops runs we may encounter issues with the number of open files, it can cause db bench to get stuck during run,
for more details and solutions please track the instructions at increase_number_of_open_files.txt

2. During cmake we may face linkage errors related to gflags, please track the instruction at install_shared_gflags.txt  


Supported benchmarks
====================
1. fillseq
2. overwrite
3. readRandom
4. writeSeq
5. readWhileWriting
6. readRandomWriteRandom
7. seekrandom


Running examples
================
**Fill stage, no-PSP:**
sudo ./db_bench --allow_concurrent_memtable_write=0 --benchmarks=fillseq --bloom_bits=10 --bloom_locality=0 --bytes_per_sync=8338608 --cache_index_and_filter_blocks=0 --cache_size=0 --compaction_style=0 --compression_ratio=1.0 --compression_type=none --db=/media/pliops/dbbench/db/db_k16_v16384 --delete_obsolete_files_period_micros=172800000000 --disable_auto_compactions=0 --disable_wal=1 --duration=0 --histogram=1 --key_size=16 --level0_file_num_compaction_trigger=2 --level0_slowdown_writes_trigger=32 --level0_stop_writes_trigger=32 --level_compaction_dynamic_level_bytes=1 --max_background_jobs=32 --max_bytes_for_level_base=1073741824 --max_bytes_for_level_multiplier=8 --max_write_buffer_number=2 --memtablerep=vector --min_level_to_compress=-1 --min_write_buffer_number_to_merge=1 --mmap_read=0 --mmap_write=0 --num_levels=6 --optimize_filters_for_hits=1 --pin_l0_filter_and_index_blocks_in_cache=0 --rate_limit_delay_max_milliseconds=1000000 --report_bg_io_stats=1 --reverse_iterator=False --seed=0 --soft_pending_compaction_bytes_limit=0 --statistics=0 --stats_interval_seconds=10 --stats_per_interval=1 --subcompactions=1 --sync=0 --target_file_size_base=134217728 --target_file_size_multiplier=1 --threads=1 --use_adaptive_mutex=0 --use_direct_reads=0 --use_existing_db=0 --use_fsync=0 --verify_checksum=1 --wal_dir=/media/pliops/dbbench/wal/db_k16_v16384 --write_buffer_size=134217728  --num=650000000 --value_size=1024 --block_size=16384  _--pliops_disk=0 --instance=1_ 

**Overwrite, no-PSP:**
sudo ./db_bench --benchmarks=overwrite --block_size=16384 --bloom_bits=10 --bloom_locality=0 --bytes_per_sync=8338608 --cache_index_and_filter_blocks=0 --cache_size=0 --compaction_style=0 --compression_ratio=1 --compression_type=none --db=/media/pliops/dbbench/db/db_k16_v1024 --delete_obsolete_files_period_micros=172800000000 --disable_auto_compactions=0 --disable_wal=0 --duration=21600 --histogram=1 --instance=1 --key_size=16 --level0_file_num_compaction_trigger=2 --level0_slowdown_writes_trigger=32 --level0_stop_writes_trigger=32 --level_compaction_dynamic_level_bytes=1 --max_background_jobs=32 --max_bytes_for_level_base=1073741824 --max_bytes_for_level_multiplier=8 --max_write_buffer_number=2 --memtablerep=skip_list --min_level_to_compress=-1 --min_write_buffer_number_to_merge=4 --mmap_read=0 --mmap_write=0 --num=2578393196 --num_levels=6 --optimize_filters_for_hits=1 --pin_l0_filter_and_index_blocks_in_cache=0 --pliops_disk=0 --rate_limit_delay_max_milliseconds=1000000 --report_bg_io_stats=1 --seed=2292 --soft_pending_compaction_bytes_limit=0 --statistics=0 --stats_interval_seconds=10 --stats_per_interval=1 --subcompactions=1 --sync=0 --target_file_size_base=134217728 --target_file_size_multiplier=1 --threads=1 --use_adaptive_mutex=0 --use_direct_reads=0 --use_existing_db=1 --use_fsync=0 --value_size=1024 --verify_checksum=1 --wal_dir=/media/pliops/dbbench/wal/db_k16_v1024 --write_buffer_size=134217728 

**Fill stage, PSP:**
sudo ./db_bench --allow_concurrent_memtable_write=0 --benchmarks=fillseq --bloom_bits=10 --bloom_locality=0 --bytes_per_sync=8338608 --cache_index_and_filter_blocks=0 --cache_size=0 --compaction_style=0 --compression_ratio=1.0 --compression_type=none --db=/media/pliops/dbbench/db/db_k16_v16384 --delete_obsolete_files_period_micros=172800000000 --disable_auto_compactions=0 --disable_wal=1 --duration=0 --histogram=1 --key_size=16 --level0_file_num_compaction_trigger=2 --level0_slowdown_writes_trigger=32 --level0_stop_writes_trigger=32 --level_compaction_dynamic_level_bytes=1 --max_background_jobs=32 --max_bytes_for_level_base=1073741824 --max_bytes_for_level_multiplier=8 --max_write_buffer_number=2 --memtablerep=vector --min_level_to_compress=-1 --min_write_buffer_number_to_merge=1 --mmap_read=0 --mmap_write=0 --num_levels=6 --optimize_filters_for_hits=1 --pin_l0_filter_and_index_blocks_in_cache=0 --rate_limit_delay_max_milliseconds=1000000 --report_bg_io_stats=1 --reverse_iterator=False --seed=0 --soft_pending_compaction_bytes_limit=0 --statistics=0 --stats_interval_seconds=10 --stats_per_interval=1 --subcompactions=1 --sync=0 --target_file_size_base=134217728 --target_file_size_multiplier=1 --threads=1 --use_adaptive_mutex=0 --use_direct_reads=0 --use_existing_db=0 --use_fsync=0 --verify_checksum=1 --wal_dir=/media/pliops/dbbench/wal/db_k16_v16384 --write_buffer_size=134217728  --num=650000000 --value_size=1024 --block_size=16384  _--pliops_disk=1 --instance=1_ 


**Overwrite, PSP:**
sudo ./db_bench --benchmarks=overwrite --block_size=16384 --bloom_bits=10 --bloom_locality=0 --bytes_per_sync=8338608 --cache_index_and_filter_blocks=0 --cache_size=0 --compaction_style=0 --compression_ratio=1 --compression_type=none --db=/media/pliops/dbbench/db/db_k16_v1024 --delete_obsolete_files_period_micros=172800000000 --disable_auto_compactions=0 --disable_wal=0 --duration=21600 --histogram=1 --instance=1 --key_size=16 --level0_file_num_compaction_trigger=2 --level0_slowdown_writes_trigger=32 --level0_stop_writes_trigger=32 --level_compaction_dynamic_level_bytes=1 --max_background_jobs=32 --max_bytes_for_level_base=1073741824 --max_bytes_for_level_multiplier=8 --max_write_buffer_number=2 --memtablerep=skip_list --min_level_to_compress=-1 --min_write_buffer_number_to_merge=4 --mmap_read=0 --mmap_write=0 --num=2578393196 --num_levels=6 --optimize_filters_for_hits=1 --pin_l0_filter_and_index_blocks_in_cache=0 --pliops_disk=1 --rate_limit_delay_max_milliseconds=1000000 --report_bg_io_stats=1 --seed=2292 --soft_pending_compaction_bytes_limit=0 --statistics=0 --stats_interval_seconds=10 --stats_per_interval=1 --subcompactions=1 --sync=0 --target_file_size_base=134217728 --target_file_size_multiplier=1 --threads=1 --use_adaptive_mutex=0 --use_direct_reads=0 --use_existing_db=1 --use_fsync=0 --value_size=1024 --verify_checksum=1 --wal_dir=/media/pliops/dbbench/wal/db_k16_v1024 --write_buffer_size=134217728 
