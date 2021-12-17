module BenchLookupIP where

import Criterion
import Data
import LookupIP
import NFUtils

bench_lookupIP :: [Benchmark]
bench_lookupIP =
  [ env iprdb $ \iprdb' ->
      bgroup
        "lookupIP"
        [ bgroup "single" $
            map
              ( \(textip, ip) ->
                  bench textip $
                    whnf (lookupIP iprdb') ip
              )
              ips,
          bench "several" $ nf (map (lookupIP iprdb')) $ map snd ips
        ]
  ]