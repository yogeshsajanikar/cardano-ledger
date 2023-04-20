{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_pretty (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_pretty"
version :: Version
version = Version [1,1,0,0] []

synopsis :: String
synopsis = "Pretty-printers for Cardano ledger datatypes"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
