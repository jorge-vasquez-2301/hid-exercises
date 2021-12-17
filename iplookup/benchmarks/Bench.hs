import BenchBuildIPGroups
import BenchLookupIP (bench_lookupIP)
import BenchParseIP
import BenchRanges (bench_ranges)
import Criterion.Main

main :: IO ()
main = defaultMain benchmarks
  where
    benchmarks = bench_buildIP <> bench_parseIP <> bench_ranges <> bench_lookupIP