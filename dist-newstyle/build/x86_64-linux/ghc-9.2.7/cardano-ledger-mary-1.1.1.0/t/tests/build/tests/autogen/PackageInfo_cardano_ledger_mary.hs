{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_mary (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_mary"
version :: Version
version = Version [1,1,1,0] []

synopsis :: String
synopsis = "Cardano ledger with multiasset support."
copyright :: String
copyright = ""
homepage :: String
homepage = ""
