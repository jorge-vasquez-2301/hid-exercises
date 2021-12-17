module Main where

import Test.DocTest

main :: IO ()
main = doctest ["-XTypeApplications", "src/ParseIP.hs"]