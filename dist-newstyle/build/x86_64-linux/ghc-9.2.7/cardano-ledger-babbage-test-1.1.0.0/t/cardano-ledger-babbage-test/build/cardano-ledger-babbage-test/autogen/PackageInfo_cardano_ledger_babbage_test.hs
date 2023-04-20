{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_babbage_test (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_babbage_test"
version :: Version
version = Version [1,1,0,0] []

synopsis :: String
synopsis = "Tests for Cardano ledger babbage era"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
