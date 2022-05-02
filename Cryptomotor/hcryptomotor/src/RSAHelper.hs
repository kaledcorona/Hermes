module RSAHelper (exampleHashWith) where

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
