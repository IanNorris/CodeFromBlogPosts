#pragma once

#include <iostream>
#include <iomanip>
#include <list>
#include <vector>
#include <array>
#include <chrono>
#include <memory>
#include <math.h>

using namespace std;

#define BENCHMARK(version,description) RunBenchmark<version>(#version,description)

#define DEFAULT_NAME "Default"
#define NOINLINE_NAME "NoInline"
#define FORCEINLINE_NAME "ForceInline"

#define DEFAULT_INLINE
#define INLINE inline

#if defined(_MSC_VER)
#define NO_INLINE __declspec(noinline)
#define FORCE_INLINE __forceinline 
#else
#define MemoryBarrier()
#define NO_INLINE __attribute__((noinline))
#define FORCE_INLINE __always_inline 
#endif

#if !defined(INLINE_STATUS)
#define INLINE_STATUS DEFAULT_INLINE
#define INLINE_NAME DEFAULT_NAME
#endif
