{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_api (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_api"
version :: Version
version = Version [1,1,0,0] []

synopsis :: String
synopsis = "Public API for the cardano ledger codebase"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
