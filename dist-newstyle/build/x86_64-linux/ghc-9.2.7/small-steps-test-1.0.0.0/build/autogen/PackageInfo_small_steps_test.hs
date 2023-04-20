{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_small_steps_test (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "small_steps_test"
version :: Version
version = Version [1,0,0,0] []

synopsis :: String
synopsis = "Small step semantics testing library"
copyright :: String
copyright = ""
homepage :: String
homepage = "https://github.com/input-output-hk/cardano-ledger"
