{- Import modules -}
import           Control.Applicative
import           Options
import           Prelude
import           System.IO
import           RSALib
import qualified Data.Text.IO                as TIO
import qualified Data.Text                   as TS
import qualified Data.Text.Encoding          as TSE
import qualified Data.ByteString             as BS
import qualified Data.ByteString.UTF8        as BSU  -- from utf8-string
import qualified Data.ByteArray              as BA
import           Crypto.Random.Types


{- Declare the options for the function -}
data MainOptions = MainOptions
    {
        optKeyFilepath :: String
    ,   optHash        :: String
    }

{- Generate default configurations for opts -}
instance Options MainOptions where
    defineOptions = pure MainOptions
        <*> simpleOption "key" ""
            "Pass the Filepath to user's private key"
        <*> simpleOption "hash" "2e6e446dac27fbf0ea51bdc43a8ce3913d89d8f24e95e004917e823fb1c03f7bfe2f10b90c198cb0f6f468e2c5420464"
            "Pass the hash384 digest of the function"
        

{- Returns a string of [Integer] representing the encrypted text -}
encryptText :: String -> (Integer,Integer) -> String
encryptText msg (n,e) = show encodedIntegers 
    where encodedIntegers = map (\x -> powerMod x e n ) $ encodeTextInt msg


main :: IO ()
main = runCommand $ \opts args -> do 
    prvKey <- openFile (optKeyFilepath opts) ReadMode   -- Open Keyfile
    key <- hGetLine prvKey                              -- Read private key from keyfile
    let (n,d) = read (key) :: (Integer,Integer)         -- convert key to a tuple of integers
    let hashDigest = (optHash opts)                     -- Read hash digest from users input
    let signDoc = encryptText hashDigest (n,d)          -- Encrypt hash digest with user's private key
    writeFile ("./signature.sig") (signDoc)             -- Create a file calle ./signature and write in it the encrypted hash digest
    hClose prvKey                                       -- Close the document Keyfile

        

