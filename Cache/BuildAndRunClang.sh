OPTS=-O2

clang++ $OPTS -DPARTIAL_WRITEBACK -DINLINE_STATUS=DEFAULT_INLINE -DINLINE_NAME=DEFAULT_NAME Benchmark.cpp -o Benchmark_Clang_PartialWriteback_DefaultInline
clang++ $OPTS -DFULL_WRITEBACK -DINLINE_STATUS=NO_INLINE -DINLINE_NAME=DEFAULT_NAME Benchmark.cpp -o Benchmark_Clang_FullWriteback_DefaultInline

clang++ $OPTS -DPARTIAL_WRITEBACK -DINLINE_STATUS=NO_INLINE -DINLINE_NAME=NOINLINE_NAME Benchmark.cpp -o Benchmark_Clang_PartialWriteback_NoInline
clang++ $OPTS -DFULL_WRITEBACK -DINLINE_STATUS=NO_INLINE -DINLINE_NAME=NOINLINE_NAME Benchmark.cpp -o Benchmark_Clang_FullWriteback_NoInline

clang++ $OPTS -DPARTIAL_WRITEBACK -DINLINE_STATUS=FORCE_INLINE -DINLINE_NAME=FORCEINLINE_NAME Benchmark.cpp -o Benchmark_Clang_PartialWriteback_ForceInline
clang++ $OPTS -DFULL_WRITEBACK -DINLINE_STATUS=FORCE_INLINE -DINLINE_NAME=FORCEINLINE_NAME Benchmark.cpp -o Benchmark_Clang_FullWriteback_ForceInline

echo Running Benchmark_Clang_PartialWriteback_DefaultInline
./Benchmark_Clang_PartialWriteback_DefaultInline > ClangResults.csv

echo Running Benchmark_Clang_FullWriteback_DefaultInline
./Benchmark_Clang_FullWriteback_DefaultInline >> ClangResults.csv

echo Running Benchmark_Clang_PartialWriteback_NoInline
./Benchmark_Clang_PartialWriteback_NoInline >> ClangResults.csv

echo Running Benchmark_Clang_FullWriteback_NoInline
./Benchmark_Clang_FullWriteback_NoInline >> ClangResults.csv

echo Running Benchmark_Clang_PartialWriteback_ForceInline
./Benchmark_Clang_PartialWriteback_ForceInline >> ClangResults.csv

echo Running Benchmark_Clang_FullWriteback_ForceInline
./Benchmark_Clang_FullWriteback_ForceInline >> ClangResults.csv

echo Done!
