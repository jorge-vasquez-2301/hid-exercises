module TempPhantom where

import Data.Proxy

newtype Temp unit = Temp Double
  deriving (Num, Fractional)

data F

data C

data K

-- class UnitName u where
--   unitName :: Proxy u -> String

-- instance UnitName C where
--   unitName :: Proxy C -> String
--   unitName _ = "C"

-- instance UnitName F where
--   unitName :: Proxy F -> String
--   unitName _ = "F"

-- instance UnitName K where
--   unitName _ = "K"

-- instance UnitName unit => UnitName (Temp unit) where
--   unitName _ = unitName (Proxy :: Proxy unit)

-- instance UnitName Temp where
--   unitName _ = "_unspecified unit_"

-- instance UnitName unit => Show (Temp unit) where
--   show (Temp t) = show t ++ "°" ++ unitName (Proxy :: Proxy unit)

f2c :: Temp F -> Temp C
f2c (Temp f) = Temp ((f -32) * 5 / 9)

-- unit :: forall u. UnitName u => Temp u -> String
-- unit _ = unitName (Proxy :: Proxy u)