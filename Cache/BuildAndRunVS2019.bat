cd /D %~dp0

call "%VS2019INSTALLDIR%\VC\Auxiliary\Build\vcvars64.bat"

set CL_OPTS=/O2 /EHa /GA /GL /DWIN32 /MD /D_CONSOLE Benchmark.cpp

cl %CL_OPTS% /DPARTIAL_WRITEBACK /DINLINE_STATUS=DEFAULT_INLINE /DINLINE_NAME=DEFAULT_NAME /FeBenchmark_VS2019_PartialWriteback_DefaultInline.exe
cl %CL_OPTS% /DFULL_WRITEBACK /DINLINE_STATUS=NO_INLINE /DINLINE_NAME=DEFAULT_NAME /FeBenchmark_VS2019_FullWriteback_DefaultInline.exe

cl %CL_OPTS% /DPARTIAL_WRITEBACK /DINLINE_STATUS=NO_INLINE /DINLINE_NAME=NOINLINE_NAME /FeBenchmark_VS2019_PartialWriteback_NoInline.exe
cl %CL_OPTS% /DFULL_WRITEBACK /DINLINE_STATUS=NO_INLINE /DINLINE_NAME=NOINLINE_NAME /FeBenchmark_VS2019_FullWriteback_NoInline.exe

cl %CL_OPTS% /DPARTIAL_WRITEBACK /DINLINE_STATUS=FORCE_INLINE /DINLINE_NAME=FORCEINLINE_NAME /FeBenchmark_VS2019_PartialWriteback_ForceInline.exe
cl %CL_OPTS% /DFULL_WRITEBACK /DINLINE_STATUS=FORCE_INLINE /DINLINE_NAME=FORCEINLINE_NAME /FeBenchmark_VS2019_FullWriteback_ForceInline.exe

echo Running Benchmark_VS2019_PartialWriteback_DefaultInline
Benchmark_VS2019_PartialWriteback_DefaultInline.exe > VS2019Results.csv

echo Running Benchmark_VS2019_FullWriteback_DefaultInline
Benchmark_VS2019_FullWriteback_DefaultInline.exe >> VS2019Results.csv

echo Running Benchmark_VS2019_PartialWriteback_NoInline
Benchmark_VS2019_PartialWriteback_NoInline.exe >> VS2019Results.csv

echo Running Benchmark_VS2019_FullWriteback_NoInline
Benchmark_VS2019_FullWriteback_NoInline.exe >> VS2019Results.csv

echo Running Benchmark_VS2019_PartialWriteback_ForceInline
Benchmark_VS2019_PartialWriteback_ForceInline.exe >> VS2019Results.csv

echo Running Benchmark_VS2019_FullWriteback_ForceInline
Benchmark_VS2019_FullWriteback_ForceInline.exe >> VS2019Results.csv

echo Done!
