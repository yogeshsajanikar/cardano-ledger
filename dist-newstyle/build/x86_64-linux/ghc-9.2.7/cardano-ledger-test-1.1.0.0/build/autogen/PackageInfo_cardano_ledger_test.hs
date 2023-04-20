{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_test (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_test"
version :: Version
version = Version [1,1,0,0] []

synopsis :: String
synopsis = "Testing harness, tests and benchmarks for Shelley style cardano ledgers"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
