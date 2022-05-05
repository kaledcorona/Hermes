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
import           Crypto.Random.Types
import           Crypto.Hash                 (Digest, SHA384, hash)
import           Crypto.Hash.Algorithms
import qualified Crypto.Hash.IO              as HashIO
import           System.Process              as P



{- Declare the options for the function -}
data MainOptions = MainOptions
    {
        optKeyFilepath :: String
    ,   optDocFilepath :: FilePath
    }

{- Generate default configurations for opts -}
instance Options MainOptions where
    defineOptions = pure MainOptions
        <*> simpleOption "key" "./rsa-prv.key"
            "Pass the Filepath to user's public key"
        <*> simpleOption "doc" "./document.pdf"
            "Filepath to the Document"
        


{- Returns a string of [Integer] representing the encrypted text -}
encryptText :: String -> (Integer,Integer) -> String
encryptText msg (n,e) = show encodedIntegers 
    where encodedIntegers = map (\x -> powerMod x e n ) $ encodeTextInt msg


{- Calculate hash of a file-}
readFile' :: FilePath -> IO (Map (Digest SHA384) [FilePath])
readFile' fp = do
  bs <- B.readFile fp
  let digest = hash bs -- notice lack of type signature :)
  return $ Map.singleton digest [fp]

main :: IO ()
main = Options.runCommand $ \opts args -> do

    {- Public key part -}
    prvKey <- openFile (optKeyFilepath opts) ReadMode   -- Open Keyfile
    key <- hGetLine prvKey                              -- Read private key from keyfile
    let (n,d) = read (key) :: (Integer,Integer)         -- convert key to a tuple of integers


    {- Hash document: Read Document and show digest-}
    m <- Map.unionsWith (++) <$> mapM readFile' [(optDocFilepath opts)]
    forM_ (Map.toList m) $ \(digest, files) ->
        case files of
            _ -> writeFile ("./signature.sig") (encryptText (show digest) (n,d))
    

    hClose prvKey 

        

