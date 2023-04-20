{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_conway (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_conway"
version :: Version
version = Version [1,2,0,0] []

synopsis :: String
synopsis = "Cardano ledger with an updated on-chain governance system."
copyright :: String
copyright = ""
homepage :: String
homepage = ""
