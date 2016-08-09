{-# LANGUAGE MultiParamTypeClasses, OverloadedStrings #-}

module Orphans where

import qualified Network.Haskoin.Crypto as HC
import qualified Network.Haskoin.Transaction as HT
import qualified Network.Haskoin.Util as HU

import qualified Web.HttpApiData as Web
import qualified Servant.API.ContentTypes as Content
import           Data.String.Conversions (cs)


instance Web.FromHttpApiData HC.Address where
    parseUrlPiece txt = maybe
        (Left "failed to parse Bitcoin address") Right $
            HC.base58ToAddr (cs txt)

instance Content.MimeUnrender Content.PlainText HT.Tx where
    mimeUnrender _ = undefined

instance Content.MimeUnrender Content.PlainText HT.TxHash where
    mimeUnrender _ = maybe (Left "Failed to decode TxHash") Right . HT.hexToTxHash . cs
