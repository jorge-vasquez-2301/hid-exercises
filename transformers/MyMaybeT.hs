{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances #-}

module MyMaybeT where

import Control.Applicative
import Control.Monad.IO.Class
import Control.Monad.State.Class
import Control.Monad.Trans.Class

newtype MaybeT m a = MaybeT {runMaybeT :: m (Maybe a)}

instance Functor m => Functor (MaybeT m) where
  fmap :: (a -> b) -> MaybeT m a -> MaybeT m b
  fmap f v = MaybeT $ f' <$> runMaybeT v
    where
      f' ma = f <$> ma

instance Applicative m => Applicative (MaybeT m) where
  pure :: a -> MaybeT m a
  pure a = MaybeT (pure $ Just a)

  (<*>) :: MaybeT m (a -> b) -> MaybeT m a -> MaybeT m b
  (MaybeT mf) <*> (MaybeT mx) = MaybeT ((<*>) <$> mf <*> mx)

instance Monad m => Monad (MaybeT m) where
  (>>=) :: MaybeT m a -> (a -> MaybeT m b) -> MaybeT m b
  (MaybeT ma) >>= f = MaybeT $ do
    maybeA <- ma
    case maybeA of
      Nothing -> pure Nothing
      Just a -> runMaybeT $ f a

instance MonadTrans MaybeT where
  lift :: Monad m => m a -> MaybeT m a
  lift ma = MaybeT $ fmap Just ma

instance MonadState s m => MonadState s (MaybeT m) where
  state = lift . state

instance Monad m => MonadFail (MaybeT m) where
  fail :: String -> MaybeT m a
  fail _ = MaybeT (pure Nothing)

instance Applicative m => Alternative (MaybeT m) where
  empty :: MaybeT m a
  empty = MaybeT (pure empty)

  (<|>) :: MaybeT m a -> MaybeT m a -> MaybeT m a
  (MaybeT mx) <|> (MaybeT my) = MaybeT ((<|>) <$> mx <*> my)

instance MonadIO m => MonadIO (MaybeT m) where
  liftIO :: IO a -> MaybeT m a
  liftIO = lift . liftIO
