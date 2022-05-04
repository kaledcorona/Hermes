{- Import modules -}
import           Control.Applicative
import           Options
import           Prelude
import           System.IO
import           RSALib
import           Data.Char
import qualified Data.Text.IO                as TIO
import qualified Data.Text                   as TS
import qualified Data.Text.Encoding          (encodeUtf8)
import           Data.Foldable               (forM_)
import qualified Data.ByteString             as B
import qualified Data.ByteString.UTF8        as BSU  -- from utf8-string
import qualified Data.Map.Strict             as Map
import           Data.Map.Strict             (Map)
import           Crypto.Random.Types
import           Crypto.Hash                 (Digest, SHA384, hash)
import           Crypto.Hash.Algorithms
import qualified Crypto.Hash.IO              as HashIO
import           System.Process              as P



{- Declare the options for the function -}
data MainOptions = MainOptions
    {
        optKeyFilepath :: String
    ,   optSignature   :: String
    ,   optDocFilepath :: FilePath
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



stripLeadingWhitespace :: String -> String
stripLeadingWhitespace = unlines . map (dropWhile isSpace) . lines


{- Calculate hash of a file-}
readFile' :: FilePath -> IO (Map (Digest SHA384) [FilePath])
readFile' fp = do
  bs <- B.readFile fp
  let digest = hash bs

  return $ Map.singleton digest [fp]

main :: IO ()
main = Options.runCommand $ \opts args -> do

    {- Public key part -}
    pubKey <- openFile (optKeyFilepath opts) ReadMode           -- Open Keyfile
    key <- hGetLine pubKey                                      -- Read public key from keyfile
    let (n,d) = read (key) :: (Integer,Integer)                 -- convert key to a tuple of integers

    {- Signature part -}
    signatureFile <- openFile (optSignature opts) ReadMode      -- Open Signature
    signature <- hGetLine signatureFile                         -- Read signature

    {- Hash document: Read Document and show digest-}
    m <- Map.unionsWith (++) <$> mapM readFile' [(optDocFilepath opts)]
    let decryptSign = stripLeadingWhitespace $ decryptText signature (n, d)              -- Decrypt signature with user's public key
    let decryptSign' = (take 64 decryptSign) ++ (drop 65 decryptSign)
    forM_ (Map.toList m) $ \(digest, files) ->
        case files of
            _ -> putStrLn $ show ((take 96 (show digest)) == (take 96 decryptSign'))
    hClose pubKey                                               -- Close the document Keyfile
    hClose signatureFile

        

