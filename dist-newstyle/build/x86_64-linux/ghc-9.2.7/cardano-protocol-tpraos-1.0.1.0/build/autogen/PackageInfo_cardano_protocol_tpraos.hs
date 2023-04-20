{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_cardano_protocol_tpraos (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "cardano_protocol_tpraos"
version :: Version
version = Version [1,0,1,0] []

synopsis :: String
synopsis = "Cardano Protocol: Transitional Praos"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
