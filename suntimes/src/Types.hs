module Types where

import Data.Aeson
import Data.Text
import Data.Time
import GHC.Generics

data GeoCoords = GeoCoords
  { lat :: Text,
    lon :: Text
  }
  deriving (Show, Generic, FromJSON)

type Address = Text

data WebAPIAuth = WebAPIAuth
  { timeZoneDBkey :: Text,
    email :: Text,
    agent :: Text
  }
  deriving (Show, Generic, FromJSON)

data SunTimes dt = SunTimes
  { sunrise :: dt,
    sunset :: dt
  }
  deriving (Show, Generic, FromJSON)

data When = Now | On Day
  deriving (Show)
