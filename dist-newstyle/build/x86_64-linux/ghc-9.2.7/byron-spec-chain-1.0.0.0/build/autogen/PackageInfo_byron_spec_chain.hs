{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_byron_spec_chain (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "byron_spec_chain"
version :: Version
version = Version [1,0,0,0] []

synopsis :: String
synopsis = "Executable specification of the Cardano blockchain"
copyright :: String
copyright = ""
homepage :: String
homepage = "https://github.com/input-output-hk/cardano-legder"
