module MyLib (someFunc) where


import RIO
import qualified Data.Text.IO                 as T
import qualified Data.Text                    as DText
import qualified Crypto.Cipher.RSA            as RSA
import qualified Crypto.Curve25519.Pure       as Curve
import qualified Crypto.Random.AESCtr         as RandomAES
import qualified Crypto.Random                as Random
import qualified Data.ByteString.Char8        as B
import qualified Crypto.Hash.SHA256           (hash)
import qualified Data.Tuple.Select            as T.Select

someFunc :: IO ()
someFunc = do
    g <- Random.newGenIO :: IO AESRNG
    let Right ((pub,priv),g1) = generate g (512 {- number of bits large -}) (7 {- a prime -})
    msg = "This is my message"
    Right (ct,g2) = encrypt g1 pub msg
    print $ decrypt priv ct
    print $ decrypt priv ct == Right msg