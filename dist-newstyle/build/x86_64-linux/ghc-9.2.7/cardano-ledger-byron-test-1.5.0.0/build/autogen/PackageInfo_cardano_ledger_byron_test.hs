{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_byron_test (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_byron_test"
version :: Version
version = Version [1,5,0,0] []

synopsis :: String
synopsis = "Test helpers from cardano-ledger exposed to other packages"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
