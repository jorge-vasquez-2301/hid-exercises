{-# LANGUAGE UnboxedSums #-}
{-# LANGUAGE UnboxedTuples #-}

module Main where

sum_prod :: Num a => a -> a -> (# a, a #)
sum_prod a b = (# a + b, a * b #)

test_sum_prod = case sum_prod 5 6 of
  (# s, p #) -> print (s + p)

fib_next :: Int -> (# Integer, Integer #) -> (# Integer, Integer #)
fib_next 0 p = p
fib_next n (# a, b #) = fib_next (n -1) (# b, a + b #)

smallest :: (# Double| (# Double, Double #) #) -> Double
smallest (# d | #) = d --
smallest (# | (# x, y #) #) = min x y

test_smallest = do
  print $ smallest (# 5.4 | #)
  print $ smallest (# | (# 2.3, 1.2 #) #)

main = case fib_next 100 (# 0, 1 #) of
  (# a, b #) -> print a
