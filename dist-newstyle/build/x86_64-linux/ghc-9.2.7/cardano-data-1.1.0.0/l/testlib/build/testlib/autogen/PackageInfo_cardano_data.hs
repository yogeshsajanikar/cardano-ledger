{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_data (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_data"
version :: Version
version = Version [1,1,0,0] []

synopsis :: String
synopsis = "Specialized data for Cardano project"
copyright :: String
copyright = ""
homepage :: String
homepage = "https://github.com/input-output-hk/cardano-ledger"
