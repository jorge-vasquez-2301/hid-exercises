module FileCounter where

import AppRWST
import AppTypes
import Control.Monad.RWS
import System.Directory.Extra (listFiles)
import System.PosixCompat
import Utils

fileCount :: MyApp (FilePath, Int) s ()
fileCount = do
  AppEnv {..} <- ask
  fs <- currentPathStatus
  when (isDirectory fs && depth <= maxDepth cfg) $ do
    traverseDirectoryWith fileCount
    files <- liftIO $ listFiles path
    tell [(path, length $ filter (checkExtension cfg) files)]