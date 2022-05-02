{- Import modules -}
import           System.IO
import           RSALib
import           Prelude
import qualified Data.Text.IO                as TIO
import qualified Data.Text                   as TS
import qualified Data.Text.Lazy              as TL
import qualified Data.ByteString             as BS
import qualified Data.ByteString.Lazy.UTF8   as BLU  -- from utf8-string
import qualified Data.ByteString.UTF8        as BSU  -- from utf8-string
import qualified Data.ByteString.Lazy        as BL
import qualified Data.ByteArray              as BA
import qualified Crypto.Hash                 as H
import           Crypto.Hash.Algorithms
import           Crypto.Random.Types
import qualified Crypto.Number.ModArithmetic as ModA


main :: IO ()
main = do

    -- Comment when not in testing
    pubKey <- openFile "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/bins/rsa-pub.key" ReadMode

    -- UnComment for production
    -- pubKey <- openFile "rsa-pub.key" ReadMode

    {- Read the public key-}
    key <- hGetLine pubKey

    {- Read the original message from the stdin -}
    contents <- getContents

    {- Read the digital signature from stdin -}
    dfirm <- getContents

    {- Read public key and convert to tuple of Integers-}
    let (n,e) = read (key) :: (Integer,Integer)

    {- Convert string content to ByteString -}
    let bsContents = BSU.fromString contents

    {- Calculate the hash of the file -}
    let hashcontent = hashWith384 bsContents

    {- Decrypt the content of the digest with public key-}
    let decContents = decryptText dfirm (n,e)
    hClose pubKey

    {- Verify if digital firm is equal to the message-}
    TIO.putStrLn $ TS.pack $ show $ verify dfirm hashcontent

{- Recovers the decrypted text from a string containing an encrypted [Integer] list -}
decryptText :: String -> (Integer,Integer) -> String
decryptText msg (n,d) = decodeIntText $ map (\x -> powerMod x d n ) $ encryptedList
	where encryptedList = read msg :: [Integer] 


{- Returns the SHA384 of a file -}
hashWith384 :: BS.ByteString -> String
hashWith384 msg = show (H.hashWith H.SHA384 msg)

{- Returns a Bool if the file is verified -}
verify :: String -> String -> Bool
verify firm msg = if (firm == msg) then True else False
