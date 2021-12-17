module BenchParseIP where

import Criterion
import Data
import NFUtils
import ParseIP

bench_parseIP :: [Benchmark]
bench_parseIP =
  [ bench "parseIP/current" $ nf (map parseIP) iptexts
  ]