{- Import modules -}
import           System.IO
import           RSALib
import           Prelude
import qualified Data.Text.IO                as TIO
import qualified Data.Text                   as TS
import qualified Data.Text.Lazy              as TL
import qualified Data.Text.Encoding          as TSE
import qualified Data.ByteString             as BS
import qualified Data.ByteString.Lazy.UTF8   as BLU  -- from utf8-string
import qualified Data.ByteString.UTF8        as BSU  -- from utf8-string
import qualified Data.ByteString.Lazy        as BL
import qualified Data.ByteArray              as BA
import qualified Crypto.Hash                 as H
import           System.Process
import           Crypto.Hash.Algorithms
import           Crypto.Random.Types
import qualified Crypto.Number.ModArithmetic as ModA


main :: IO ()
main = do

    -- Comment when not in testing
    prvKey <- openFile "./bins/rsa-prv.key" ReadMode


    {- Read the privkey key-}
    key <- hGetLine prvKey


    {- Read public key and convert to tuple of Integers-}
    -- let (n,d) = read (key) :: (Integer,Integer)

    {- Read hash from stdin -}
    -- let hashContent =  TIO.hGetLine

    -- TIO.hPutStrLn (hashContent :: TS.Text)

    {- Encrypt the content of the digest with  private key-}
    -- let encContents = encryptText contents (n,d)

    {- Save the message and the signature of the message in a file -}
    -- Comment this line when not testing 
    -- writeFile ("/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/signature") (encContents)
    -- uncomment when production
    -- TIO.writeFile ("./signature") (T.pack encContents)
    hClose prvKey
        

{- Returns a string of [Integer] representing the encrypted text -}
encryptText :: String -> (Integer,Integer) -> String
encryptText msg (n,e) = show encodedIntegers 
    where encodedIntegers = map (\x -> powerMod x e n ) $ encodeTextInt msg
