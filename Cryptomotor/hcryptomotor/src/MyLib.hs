module MyLib (exampleHashWith, exampleIncrWithAllocs, exampleIncrInPlace) where

import           Prelude                  
import           Data.ByteString          (ByteString)
import qualified Data.ByteArray           as BA
import qualified Data.ByteString          as B

import qualified Crypto.PubKey.Curve25519 as X25519
import qualified Crypto.Hash              as H
import Crypto.Hash.Algorithms
import Crypto.Hash.IO




exampleHashWith :: ByteString -> IO ()
exampleHashWith msg = do
    putStrLn $  " sha1(" ++ show msg ++") = " ++ show (H.hashWith H.SHA1 msg)
    putStrLn $  "sha256(" ++ show msg ++ ") = " ++ show (H.hashWith H.SHA256 msg)


exampleIncrWithAllocs :: IO ()
exampleIncrWithAllocs = do
    let ctx0 = H.hashInitWith SHA3_512
        ctx1 = H.hashUpdate ctx0 ("The "   :: ByteString)
        ctx2 = H.hashUpdate ctx1 ("quick " :: ByteString)
        ctx3 = H.hashUpdate ctx2 ("brown " :: ByteString)
        ctx4 = H.hashUpdate ctx3 ("fox "   :: ByteString)
        ctx5 = H.hashUpdate ctx4 ("jumps " :: ByteString)
        ctx6 = H.hashUpdate ctx5 ("over "  :: ByteString)
        ctx7 = H.hashUpdate ctx6 ("the "   :: ByteString)
        ctx8 = H.hashUpdate ctx7 ("lazy "  :: ByteString)
        ctx9 = H.hashUpdate ctx8 ("dog"    :: ByteString)
    print (H.hashFinalize ctx9)



exampleIncrInPlace :: IO ()
exampleIncrInPlace = do
    ctx <- hashMutableInitWith SHA3_512
    hashMutableUpdate ctx ("The "   :: ByteString)
    hashMutableUpdate ctx ("quick " :: ByteString)
    hashMutableUpdate ctx ("brown " :: ByteString)
    hashMutableUpdate ctx ("fox "   :: ByteString)
    hashMutableUpdate ctx ("jumps " :: ByteString)
    hashMutableUpdate ctx ("over "  :: ByteString)
    hashMutableUpdate ctx ("the "   :: ByteString)
    hashMutableUpdate ctx ("lazy "  :: ByteString)
    hashMutableUpdate ctx ("dog"    :: ByteString)
    hashMutableFinalize ctx >>= print