{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_vector_map (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "vector_map"
version :: Version
version = Version [1,0,1,0] []

synopsis :: String
synopsis = "An efficient VMap that is backed by two vectors: one for keys and another for values."
copyright :: String
copyright = ""
homepage :: String
homepage = "https://github.com/input-output-hk/cardano-ledger"
