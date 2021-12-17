{-# LANGUAGE NoDeriveAnyClass #-}

module App where

import Control.Monad.Catch
import Control.Monad.Logger
import Control.Monad.Logger (MonadLogger)
import Control.Monad.Reader
import Types

newtype MyApp a = MyApp
  { runApp :: ReaderT WebAPIAuth (LoggingT IO) a
  }
  deriving
    ( Functor,
      Applicative,
      Monad,
      MonadIO,
      MonadThrow,
      MonadCatch,
      MonadMask,
      MonadReader WebAPIAuth,
      MonadLogger
    )

runMyApp :: MyApp a -> WebAPIAuth -> IO a
runMyApp app config = runStderrLoggingT $ runReaderT (runApp app) config