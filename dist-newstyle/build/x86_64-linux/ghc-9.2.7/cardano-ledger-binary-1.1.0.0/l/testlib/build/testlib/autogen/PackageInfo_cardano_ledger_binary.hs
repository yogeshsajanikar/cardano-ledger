{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_ledger_binary (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_ledger_binary"
version :: Version
version = Version [1,1,0,0] []

synopsis :: String
synopsis = "Binary serialization library used throughout ledger"
copyright :: String
copyright = ""
homepage :: String
homepage = "https://github.com/input-output-hk/cardano-ledger"
