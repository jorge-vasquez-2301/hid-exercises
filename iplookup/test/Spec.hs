import GoldenTests
import LookupIPSpec
import ParseIPSpec
import Props
import Test.Tasty
import Test.Tasty.Hspec

main :: IO ()
main = do
  specs <-
    concat
      <$> mapM
        testSpecs
        [ parseIPSpecs,
          lookupIPSpecs
        ]
  goldens <- goldenTests
  defaultMain
    ( testGroup
        "All Tests"
        [ testGroup "Specs" specs,
          testGroup "Properties" props,
          testGroup "Golden Tests" goldens
        ]
    )