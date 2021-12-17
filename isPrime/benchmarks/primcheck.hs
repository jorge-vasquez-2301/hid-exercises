import Criterion.Main
 
import qualified IsPrime as IP
import qualified IsPrimeUnfolded as IPU
 
primeNumber :: Integer
primeNumber = 16183
 
main :: IO ()
main = defaultMain [
    bench "isPrime (declarative)" $ whnf IP.isPrime primeNumber
  , bench "isPrime (unfolded)" $ whnf IPU.isPrime primeNumber
  ]