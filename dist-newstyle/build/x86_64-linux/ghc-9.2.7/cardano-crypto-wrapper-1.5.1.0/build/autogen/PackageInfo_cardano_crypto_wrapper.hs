{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_crypto_wrapper (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_crypto_wrapper"
version :: Version
version = Version [1,5,1,0] []

synopsis :: String
synopsis = "Cryptographic primitives used in Byron era of the Cardano project"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
