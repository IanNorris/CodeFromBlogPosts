#include "Common.h"

#include "Version1.h"
#include "Version2.h"
#include "Version3.h"
#include "Version4.h"
#include "Version5.h"
#include "Version6.h"
#include "Version7.h"

const unsigned int RunCount = 50;
const unsigned int ArraySize = 1000000;

template<typename Version>
INLINE_STATUS void RunBenchmarkCoreLoop(Version& version, int writeOffset)
{
	int index = 0;
	for (auto& item : version.Data)
	{
		float result = 0.0f;

		float* actualData1 = version.GetActualData1(item, index);
		float* actualData2 = version.GetActualData2(item, index);

		result -= (actualData1[0] + actualData2[0]);
		result += (actualData1[1] + actualData2[1]);
		result *= 1.0f + (actualData1[2] + actualData2[2]);
		result /= 1.0f - (actualData1[3] + actualData2[3]);
		result -= (actualData1[4] + actualData2[4]);
		result /= 1.0f + (actualData1[5] + actualData2[5]);
		result *= 1.0f + (actualData1[6] + actualData2[6]);
		result += (actualData1[7] + actualData2[7]);

#if defined(PARTIAL_WRITEBACK)
		if ((index + writeOffset) % 100 == 0)
#endif
		{
			version.WriteResult(item, result, index);
		}

		index++;
	}
}

template<typename Version>
INLINE_STATUS double RunBenchmarkInternal(Version& version, chrono::nanoseconds& totalRuntime)
{
	chrono::high_resolution_clock clock;

	double totalResult = 0.0f;
	for (unsigned int runs = 0; runs < RunCount; runs++)
	{
		auto before = clock.now();

		RunBenchmarkCoreLoop<Version>(version, rand());
		
		auto after = clock.now();

		int index = 0;
		for (const auto& item : version.Data)
		{
			float result = version.GetResult(item, index);

			totalResult += (double)result;

			index++;
		}

		auto runtime = chrono::duration_cast<chrono::nanoseconds>(after - before);

		totalRuntime += runtime;
	}
	
	return totalResult;
}

template<typename Version>
void RunBenchmark(const char* versionName, const char* description)
{
	Version version;

	//Initialization is inefficient, we don't care though as we're
	//not benchmarking this bit.
	for (unsigned int i = 0; i < ArraySize; i++)
	{
		typename Version::MyData item;

		version.SetupExtraData(item, i);

		float* actualData1 = version.GetActualData1(item, i);
		float* actualData2 = version.GetActualData2(item, i);

		for (int j = 0; j < 8; j++)
		{
			actualData1[j] = (float)j * 3.054f;
			actualData2[j] = sin((float)j * 1.164f);
		}

		version.Data.push_back(item);
	}

	chrono::nanoseconds totalRuntime = 0ns;

	srand(12345);

	double totalResult = RunBenchmarkInternal(version, totalRuntime);
	

	long long averageRuntimeNS = totalRuntime.count() / RunCount;

	//Yes there are technically better ways to do this, but this is more readable
	double averageRuntimeMS = averageRuntimeNS / (1000.0 * 1000.0);

	cout << versionName << "," << sizeof(typename Version::MyData) << "," << averageRuntimeNS << "," << averageRuntimeMS << "," << description << "," << setprecision(4) << totalResult << "," << endl;
}

int main()
{
	cout << "Compiler: " <<
#if defined(_MSC_VER)
		"MSVC"
#elif defined(__clang__)
		"Clang"
#elif defined(__GNUC__)
		"GCC"
#else
		"Unknown"
#endif
		<< " + Write Back: " <<
#if defined(PARTIAL_WRITEBACK)
		"Partial"
#else
		"Full"
#endif
		<< " + Inline: " << INLINE_NAME << endl;

	//We're outputting a CSV file for easier graphing
	cout << "Name,Struct Size,Average Time NS,Average Time MS,Result Value," << endl;
	
	BENCHMARK(Version1, "Base");
	BENCHMARK(Version2, "Removed indirection for Transform");
	BENCHMARK(Version3, "Changed list to vector");
	BENCHMARK(Version4, "Optimized packing");
	BENCHMARK(Version5, "Swapped boolean type");
	BENCHMARK(Version6, "Moved infrequently accessed data");
	BENCHMARK(Version7, "Fully committed to data-oriented design");

	return 0;
}
