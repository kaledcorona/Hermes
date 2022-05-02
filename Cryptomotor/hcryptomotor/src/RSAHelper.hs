module RSAHelper (exampleHashWith, exampleIncrWithAllocs) where

import           Prelude                  
import           Data.ByteString             (ByteString)
import qualified Data.ByteArray              as BA
import qualified Data.ByteString             as B

-- Cryptography related modules
import qualified Crypto.PubKey.Curve25519    as X25519
import qualified Crypto.Hash                 as H
import           Crypto.Hash.Algorithms
import           Crypto.Random.Types
import qualified Crypto.Number.ModArithmetic as ModA
import qualified Crypto.Number.Prime         as Prime 






exampleHashWith :: ByteString -> IO ()
exampleHashWith msg = do
    putStrLn $  " sha1(" ++ show msg ++") = " ++ show (H.hashWith H.SHA1 msg)
    putStrLn $  "sha384(" ++ show msg ++ ") = " ++ show (H.hashWith H.SHA384 msg)



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

