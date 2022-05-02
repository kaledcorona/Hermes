
{- Import modules -}
import System.IO
import RSALib
import Prelude
import qualified Data.Text.IO as TIO
import qualified Data.Text    as T

main :: IO ()
main = do
    -- Comment when not in testing
    prvKey <- openFile "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/bins/rsa-prv.key" ReadMode

    -- UnComment for production
    -- prvKey <- openFile "rsa-prv.key" ReadMode

    {- Read the public key-}
    key <- hGetLine prvKey

    {- Read from stdin-}
    contents <- getContents

    {- Read private key and convert to tuple of Integers-}
    let (n,d) = read (key) :: (Integer,Integer)

    {- Decrypt the content of the msg-}
    let decContens = decryptText contents (n, d)

    {- Save encrypted mesagge in a file name decryptText-}
    -- Comment this line when not testing 
    writeFile ("/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/decryptText") (decContens)
    
    -- uncomment when production
    -- TIO.writeFile ("./encryptFile") (T.pack encContents)
    hClose prvKey
		
{- Recovers the decrypted text from a string containing an encrypted [Integer] list -}
decryptText :: String -> (Integer,Integer) -> String
decryptText msg (n,d) = decodeIntText $ map (\x -> powerMod x d n ) $ encryptedList
	where encryptedList = read msg :: [Integer] 
