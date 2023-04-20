{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_crypto_test (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_crypto_test"
version :: Version
version = Version [1,5,0,0] []

synopsis :: String
synopsis = "Test helpers from cardano-crypto exposed to other packages"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
