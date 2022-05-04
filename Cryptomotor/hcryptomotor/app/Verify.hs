{- Import modules -}
import           Control.Applicative
import           Options
import           Prelude
import           System.IO
import           RSALib
import qualified Data.Text.IO                as TIO
import qualified Data.Text                   as TS
import qualified Data.Text.Encoding          as TSE
import qualified Data.ByteString             (ByteString)
import qualified Data.ByteString.UTF8        as BSU  -- from utf8-string
-- import qualified Data.ByteArray              as BA
import           Crypto.Random.Types
import           Crypto.Hash
import           Crypto.Hash.Algorithms
import qualified Crypto.Hash.IO              as HashIO
import           System.Process              as P



{- Declare the options for the function -}
data MainOptions = MainOptions
    {
        optKeyFilepath :: String
    ,   optSignature   :: String
    ,   optDocFilepath :: String
    }

{- Generate default configurations for opts -}
instance Options MainOptions where
    defineOptions = pure MainOptions
        <*> simpleOption "pubkey" "./rsa-pub.key"
            "Pass the Filepath to user's public key"
        <*> simpleOption "sig" "./signature.sig"
            "Pass the hash384 digest of the function"
        <*> simpleOption "doc" "./document.pdf"
            "Filepath to the Document"
        


{- Recovers the decrypted text from a string containing an encrypted [Integer] list -}
decryptText :: String -> (Integer,Integer) -> String
decryptText msg (n,d) = decodeIntText $ map (\x -> powerMod x d n ) $ encryptedList
	where encryptedList = read msg :: [Integer] 


{- Verify if the decrypted signature is equal to the hash digest of the document-}
verifySignature :: String -> String -> String
verifySignature signDecrypted hashDoc 
    | signDecrypted == hashDoc = "True"
    | otherwise                = "False"


{- Calculate hash of a file-}


main :: IO ()
main = Options.runCommand $ \opts args -> do 

    {- Public key part -}
    pubKey <- openFile (optKeyFilepath opts) ReadMode           -- Open Keyfile
    key <- hGetLine pubKey                                      -- Read public key from keyfile
    let (n,d) = read (key) :: (Integer,Integer)                 -- convert key to a tuple of integers

    {- Signature part -}
    signatureFile <- openFile (optSignature opts) ReadMode      -- Open Signature
    signature <- hGetLine signatureFile                         -- Read signature

    {- Document part -}
    document <- openFile (optDocFilepath opts) ReadMode         -- Open document
    let content = hShow document                                -- Read document
    -- let btsDocument   = fmap BSU.fromString content             -- Convert from strings to binary data

    {- Hash -}
    -- let hashDigest = hash btsDocument :: Digest SHA384          -- Hash the document
    -- let hashText = show hashDigest                              -- Hash as string

    {- Decryption -}
    -- let decryptSign = decryptText signature (n, d)              -- Decrypt signature with user's public key
    -- let validation = verifySignature  hashText signature        -- Validate if the signature is correct
    -- putStrLn validation                                         -- Write in stdout the result
    hClose pubKey                                               -- Close the document Keyfile
    hClose document
    hClose signatureFile
        

