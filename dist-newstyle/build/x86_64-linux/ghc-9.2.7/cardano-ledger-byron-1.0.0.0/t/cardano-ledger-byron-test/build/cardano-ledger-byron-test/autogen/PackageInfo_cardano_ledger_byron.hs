{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_byron (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_byron"
version :: Version
version = Version [1,0,0,0] []

synopsis :: String
synopsis = "The blockchain layer of Cardano during the Byron era"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
