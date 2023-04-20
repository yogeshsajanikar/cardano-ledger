{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_alonzo_test (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_alonzo_test"
version :: Version
version = Version [1,1,0,0] []

synopsis :: String
synopsis = "Tests for Cardano ledger introducing Plutus Core"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
