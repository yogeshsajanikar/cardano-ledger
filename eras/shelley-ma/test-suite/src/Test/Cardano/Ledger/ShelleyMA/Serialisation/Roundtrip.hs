{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Test.Cardano.Ledger.ShelleyMA.Serialisation.Roundtrip where

-- import Cardano.Ledger.Compactible (Compactible(toCompact))
import Cardano.Ledger.Allegra (Allegra)
import Cardano.Ledger.Binary (FromCBOR, ToCBOR)
import Cardano.Ledger.Binary.Version (natVersion)
import Cardano.Ledger.Coin (Coin (Coin), CompactForm (CompactCoin))
import qualified Cardano.Ledger.Core as Core
import Cardano.Ledger.Crypto (StandardCrypto)
import Cardano.Ledger.Mary (Mary)
import Cardano.Ledger.Mary.Value (
  CompactValue (..),
  MaryValue (..),
  MultiAsset (..),
 )
import Cardano.Ledger.Shelley (Shelley)
import Cardano.Ledger.Shelley.API (ApplyTx, ApplyTxError)
import Control.State.Transition.Extended (PredicateFailure)

-- import qualified Data.ByteString.Short as SBS
import qualified Data.Map.Strict as Map
import Data.Proxy (Proxy (Proxy))
import Data.Typeable (typeRep)

-- import Data.Word (Word32, Word64, Word8)
import Test.Cardano.Ledger.Binary.RoundTrip (
  cborTrip,
  roundTripAnnExpectation,
  roundTripCborExpectation,
  roundTripCborRangeExpectation,
  roundTripExpectation,
  roundTripFailureCborExpectation,
  roundTripFailureCborExpectation',
  -- roundTripFailureCborRangeExpectation,
 )
import Test.Cardano.Ledger.Shelley.Generator.TxAuxData ()
import Test.Cardano.Ledger.Shelley.Serialisation.Generators ()
import Test.Cardano.Ledger.ShelleyMA.Serialisation.Generators ()
import Test.QuickCheck (
  Arbitrary,
  Gen,
  Negative (..),
  -- elements,

  -- resize,
  NonNegative (NonNegative),
  NonZero (..),
  Positive (..),
  arbitrary,
  forAll,
  getNonZero,
  listOf1,
  vectorOf,
 )
import Test.Tasty (TestTree, testGroup)
import Test.Tasty.HUnit (testCase)
import Test.Tasty.QuickCheck (testProperty)

eraRoundTripProps ::
  forall e.
  ( ApplyTx e
  , Arbitrary (Core.TxBody e)
  , Arbitrary (Core.TxAuxData e)
  , Arbitrary (Core.Value e)
  , Arbitrary (Core.Script e)
  , Arbitrary (ApplyTxError e)
  , ToCBOR (PredicateFailure (Core.EraRule "DELEGS" e))
  , FromCBOR (PredicateFailure (Core.EraRule "DELEGS" e))
  , ToCBOR (PredicateFailure (Core.EraRule "UTXOW" e))
  , FromCBOR (PredicateFailure (Core.EraRule "UTXOW" e))
  ) =>
  TestTree
eraRoundTripProps =
  testGroup
    (show $ typeRep (Proxy @e))
    [ testProperty "TxBody" $ roundTripAnnExpectation @(Core.TxBody e)
    , testProperty "Metadata" $ roundTripAnnExpectation @(Core.TxAuxData e)
    , testProperty "Value" $ roundTripExpectation @(Core.Value e) cborTrip
    , testProperty "Script" $ roundTripAnnExpectation @(Core.Script e)
    , testProperty "ApplyTxError" $ roundTripCborExpectation @(ApplyTxError e)
    ]

allEraRoundtripTests :: TestTree
allEraRoundtripTests =
  testGroup
    "All Era Roundtrip Tests"
    [ eraRoundTripProps @Shelley
    , eraRoundTripProps @Allegra
    , eraRoundTripProps @Mary
    , valueCBORTests
    ]

coinCBORTests :: TestTree
coinCBORTests =
  testGroup
    "Coin CBOR roundtrips"
    [ testProperty "decode (NonNegative Int) as Coin for all eras" $
        \(NonNegative i) -> roundTripCborExpectation (Coin i)
    , testProperty "decode (Negative Int) as Coin for pre-conway" $
        \(Negative i) -> roundTripCborRangeExpectation minBound (natVersion @8) (Coin i)
    , testProperty "fail decode (Negative Int) as Coin for conway" $
        \(Negative i) -> roundTripFailureCborExpectation' (natVersion @9) (Coin i)
    ]

genMap :: Ord k => Gen k -> Gen v -> Gen (Map.Map k v)
genMap genKey genVal = do
  keys <- listOf1 genKey
  vals <- vectorOf (length keys) genVal
  pure $ Map.fromList $ zip keys vals

genMultiAsset :: Gen Integer -> Gen (MultiAsset StandardCrypto)
genMultiAsset genAmount = MultiAsset <$> genMap arbitrary (genMap arbitrary genAmount)

genMultiAssetMintNonZero :: Gen (MultiAsset StandardCrypto)
genMultiAssetMintNonZero = genMultiAsset (getNonZero <$> arbitrary)

genMultiAssetMintZero :: Gen (MultiAsset StandardCrypto)
genMultiAssetMintZero = genMultiAsset (pure 0)

genMaryValue :: Gen (MultiAsset StandardCrypto) -> Gen (MaryValue StandardCrypto)
genMaryValue genMA = do
  ma <- genMA
  i <- getPositive <$> arbitrary
  pure $ MaryValue i ma

genMaryValueZero :: Gen (MaryValue StandardCrypto)
genMaryValueZero = genMaryValue (genMultiAsset (pure 0))

genMaryValuePositive :: Gen (MaryValue StandardCrypto)
genMaryValuePositive = genMaryValue (genMultiAsset (getPositive <$> arbitrary))

genMaryValueNegative :: Gen (MaryValue StandardCrypto)
genMaryValueNegative = genMaryValue (genMultiAsset (getNegative <$> arbitrary))

multiAssetCBORTests :: TestTree
multiAssetCBORTests =
  testGroup
    "MultiAsset CBOR roundtrips"
    [ testProperty "decode (NonZero Int) as MultiAsset for all eras" $
        forAll genMultiAssetMintNonZero $
          roundTripCborExpectation
    , testProperty "decode 0 as MultiAsset for pre-conway" $
        forAll genMultiAssetMintZero $
          roundTripCborRangeExpectation minBound (natVersion @8)
    , testProperty "fail decode 0 as MultiAsset for conway" $
        forAll genMultiAssetMintZero $
          roundTripFailureCborExpectation' (natVersion @9)
    ]

maryValueCBORTests :: TestTree
maryValueCBORTests =
  testGroup
    "MaryValue CBOR roundtrips"
    [ testProperty "decode (Positive Int) as MaryValue for all eras" $
        forAll genMaryValuePositive $
          roundTripCborExpectation
    , testProperty "fail decode (Negative Int) as MaryValue for all eras" $
        forAll genMaryValueNegative $
          roundTripFailureCborExpectation
    , testProperty "fail decode 0 as MaryValue for conway" $
        forAll genMaryValueZero $
          roundTripFailureCborExpectation' (natVersion @9)
    , testProperty "decode 0 as MaryValue for pre-conway" $
        forAll genMaryValueZero $
          roundTripCborRangeExpectation minBound (natVersion @8)
    ]

-- genCompactValue :: Gen Word64 -> Gen (CompactValue StandardCrypto)
-- genCompactValue genWord64 = do
--   i <- elements [0 .. 31] -- genWord64
--   w32 <- elements [0 .. 31] -- arbitrary @Word32
--   sbs <- SBS.pack . (:[]) <$> arbitrary @Word8
--   elements [CompactValueAdaOnly (CompactCoin i), CompactValueMultiAsset (CompactCoin i) w32 sbs]

compactValueCBORTests :: TestTree
compactValueCBORTests =
  testGroup
    "CompactValue CBOR roundtrips"
    -- -- NOTE: These fail with error "AssetName exceed 32 bytes"
    -- [ testProperty "decode 0 as CompactValue for pre-conway" $
    --     forAll (genCompactValue (pure 0)) $  roundTripCborRangeExpectation minBound (natVersion @8)
    -- , testProperty "fail decode 0 as CompactValue for conway" $
    --     forAll (genCompactValue (pure 0)) $ roundTripFailureCborExpectation' (natVersion @9)
    -- , testProperty "decode (Positive Int) as CompactValue for all eras" $
    --     forAll (genCompactValue (getPositive <$> arbitrary)) $ roundTripCborExpectation
    -- , testProperty "fail decode (Negative Int) as CompactValue for all eras" $
    --     forAll (genCompactValue (getNegative <$> arbitrary)) $ roundTripFailureCborExpectation

    -- -- NOTE: These fail with error "Heap exhausted"
    -- [ testProperty "decode 0 as CompactValue for pre-conway" $
    --     forAll (fromJust . toCompact <$> genMaryValueZero) $ roundTripCborRangeExpectation minBound (natVersion @8)
    -- , testProperty "fail decode 0 as CompactValue for conway" $
    --     forAll (fromJust . toCompact <$> genMaryValueZero) $ roundTripFailureCborExpectation' (natVersion @9)
    -- , testProperty "decode (Positive Int) as CompactValue for all eras" $
    --     forAll (fromJust . toCompact <$> genMaryValuePositive) $ roundTripCborExpectation
    -- ,  testProperty "fail decode (Negative Int) as CompactValue for all eras" $
    --     forAll (fromJust . toCompact <$> genMaryValueNegative) $ roundTripFailureCborExpectation

    -- NOTE: These pass except the (Negative Int) one.
    [ testProperty "decode (Positive Int) as CompactValue for all eras" $
        \(Positive i) -> roundTripCborExpectation @(CompactValue StandardCrypto) (CompactValueAdaOnly (CompactCoin i))
    , testCase "decode 0 as CompactValue for pre-conway" $
        roundTripCborRangeExpectation @(CompactValue StandardCrypto) minBound (natVersion @8) (CompactValueAdaOnly (CompactCoin 0))
    , testCase "fail decode 0 as CompactValue for conway" $
        roundTripFailureCborExpectation' @(CompactValue StandardCrypto) (natVersion @9) (CompactValueAdaOnly (CompactCoin 0))
        -- , testProperty "decode (Negative Int) as CompactValue for all eras" $ -- NOTE: This gets stuck (possibly in an infinite loop)
        --     \(Negative i) -> roundTripCborExpectation @(CompactValue StandardCrypto) (CompactValueAdaOnly (CompactCoin i))
    ]

valueCBORTests :: TestTree
valueCBORTests =
  testGroup
    "Value CBOR roundtrips"
    [ coinCBORTests
    , multiAssetCBORTests
    , maryValueCBORTests
    , compactValueCBORTests
    ]
