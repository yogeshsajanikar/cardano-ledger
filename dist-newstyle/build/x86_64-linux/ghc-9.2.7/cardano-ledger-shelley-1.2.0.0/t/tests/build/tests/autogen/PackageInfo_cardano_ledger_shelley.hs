{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_shelley (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_shelley"
version :: Version
version = Version [1,2,0,0] []

synopsis :: String
synopsis = "Shelley Ledger Executable Model"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
