
{- Import modules -}
import System.IO
import RSALib
import Prelude
import qualified Data.Text.IO as TIO
import qualified Data.Text    as T


main :: IO ()
main = do

    -- Comment when not in testing
    pubKey <- openFile "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/bins/rsa-pub.key" ReadMode

    -- UnComment for production
    -- pubKey <- openFile "rsa-pub.key" ReadMode

    {- Read the public key-}
    key <- hGetLine pubKey

    {- Read from stdin-}
    contents <- getContents

    {- Read public key and convert to tuple of Integers-}
    let (n,e) = read (key) :: (Integer,Integer)

    {- Encrypt the content of the msg-}
    let encContents = encryptText contents (n,e)

    {- Save encrypted mesagge in a file name encryptText-}
    -- Comment this line when not testing 
    writeFile ("/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/encryptText") (encContents)
    -- uncomment when production
    -- TIO.writeFile ("./encryptFile") (T.pack encContents)
    hClose pubKey
        

{- Returns a string of [Integer] representing the encrypted text -}
encryptText :: String -> (Integer,Integer) -> String
encryptText msg (n,e) = show encodedIntegers 
	where encodedIntegers = map (\x -> powerMod x e n ) $ encodeTextInt msg
