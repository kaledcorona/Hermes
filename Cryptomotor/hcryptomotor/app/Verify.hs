{- Import modules -}
import           Control.Applicative
import           Options
import           Prelude
import           System.IO
import           RSALib
import qualified Data.Text.IO                as TIO
import qualified Data.Text                   as TS
import qualified Data.Text.Encoding          (encodeUtf8)
import           Data.Foldable               (forM_)
import qualified Data.ByteString             as B
import qualified Data.ByteString.UTF8        as BSU  -- from utf8-string
import qualified Data.Map.Strict             as Map
import           Data.Map.Strict             (Map)
import           System.Environment          (getArgs)
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


{- Calculate hash of a file-}
readFile' :: FilePath -> IO (Map (Digest SHA384) [FilePath])
readFile' fp = do
  bs <- B.readFile fp
  let digest = hash bs -- notice lack of type signature :)
  return $ Map.singleton digest [fp]

main :: IO ()
main = do 
    args <- getArgs
    m <- Map.unionsWith (++) <$> mapM readFile' args
    forM_ (Map.toList m) $ \(digest, files) ->
        case files of
            _ -> putStrLn $ show digest

        

