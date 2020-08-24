{-# LANGUAGE LambdaCase #-}

-- |
-- Copyright: © 2018-2020 IOHK
-- License: Apache-2.0
--
-- Logging types specific to the pool database.
--
module Cardano.Pool.DB.Log
    ( PoolDbLog (..)
    ) where

import Prelude

import Cardano.BM.Data.Severity
    ( Severity (..) )
import Cardano.BM.Data.Tracer
    ( HasPrivacyAnnotation (..), HasSeverityAnnotation (..) )
import Cardano.DB.Sqlite
    ( DBLog (..) )
import Cardano.Wallet.Logging
    ( BracketLog )
import Cardano.Wallet.Primitive.Types
    ( EpochNo, PoolId, PoolRetirementCertificate )
import Data.Text.Class
    ( ToText (..), toText )
import Fmt
    ( pretty )

import qualified Data.Text as T

data PoolDbLog
    = MsgGeneric DBLog
    | MsgRemovingPool PoolId
    | MsgRemovingRetiredPools [PoolRetirementCertificate]
    | MsgRemovingRetiredPoolsForEpoch EpochNo BracketLog
    deriving (Eq, Show)

instance HasPrivacyAnnotation PoolDbLog

instance HasSeverityAnnotation PoolDbLog where
    getSeverityAnnotation = \case
        MsgGeneric e -> getSeverityAnnotation e
        MsgRemovingPool {} -> Notice
        MsgRemovingRetiredPools {} -> Debug
        MsgRemovingRetiredPoolsForEpoch {} -> Debug

instance ToText PoolDbLog where
    toText = \case
        MsgGeneric e -> toText e
        MsgRemovingPool p -> mconcat
            [ "Removing the following pool from the database: "
            , toText p
            , "."
            ]
        MsgRemovingRetiredPools [] ->
            "There are no retired pools to remove."
        MsgRemovingRetiredPools poolRetirementCerts -> T.unlines
            [ "Removing the following retired pools:"
            , T.unlines (pretty <$> poolRetirementCerts)
            ]
        MsgRemovingRetiredPoolsForEpoch epoch nestedMessage -> T.concat
            [ "Removing pools that retired in or before epoch "
            , toText epoch
            , ": "
            , toText nestedMessage
            ]
