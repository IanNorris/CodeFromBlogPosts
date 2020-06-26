OPTS=-O2

g++ $OPTS -DPARTIAL_WRITEBACK -DINLINE_STATUS=DEFAULT_INLINE -DINLINE_NAME=DEFAULT_NAME Benchmark.cpp -o Benchmark_GCC_PartialWriteback_DefaultInline
g++ $OPTS -DFULL_WRITEBACK -DINLINE_STATUS=NO_INLINE -DINLINE_NAME=DEFAULT_NAME Benchmark.cpp -o Benchmark_GCC_FullWriteback_DefaultInline

g++ $OPTS -DPARTIAL_WRITEBACK -DINLINE_STATUS=NO_INLINE -DINLINE_NAME=NOINLINE_NAME Benchmark.cpp -o Benchmark_GCC_PartialWriteback_NoInline
g++ $OPTS -DFULL_WRITEBACK -DINLINE_STATUS=NO_INLINE -DINLINE_NAME=NOINLINE_NAME Benchmark.cpp -o Benchmark_GCC_FullWriteback_NoInline

g++ $OPTS -DPARTIAL_WRITEBACK -DINLINE_STATUS=FORCE_INLINE -DINLINE_NAME=FORCEINLINE_NAME Benchmark.cpp -o Benchmark_GCC_PartialWriteback_ForceInline
g++ $OPTS -DFULL_WRITEBACK -DINLINE_STATUS=FORCE_INLINE -DINLINE_NAME=FORCEINLINE_NAME Benchmark.cpp -o Benchmark_GCC_FullWriteback_ForceInline

echo Running Benchmark_GCC_PartialWriteback_DefaultInline
./Benchmark_GCC_PartialWriteback_DefaultInline > GCCResults.csv

echo Running Benchmark_GCC_FullWriteback_DefaultInline
./Benchmark_GCC_FullWriteback_DefaultInline >> GCCResults.csv

echo Running Benchmark_GCC_PartialWriteback_NoInline
./Benchmark_GCC_PartialWriteback_NoInline >> GCCResults.csv

echo Running Benchmark_GCC_FullWriteback_NoInline
./Benchmark_GCC_FullWriteback_NoInline >> GCCResults.csv

echo Running Benchmark_GCC_PartialWriteback_ForceInline
./Benchmark_GCC_PartialWriteback_ForceInline >> GCCResults.csv

echo Running Benchmark_GCC_FullWriteback_ForceInline
./Benchmark_GCC_FullWriteback_ForceInline >> GCCResults.csv

echo Done!
