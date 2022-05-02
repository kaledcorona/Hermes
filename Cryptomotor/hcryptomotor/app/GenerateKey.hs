import System.IO
import System.Random
import RSALib
import Prelude

main = do
	{- Create new files in writemode -}
	pubKey <- openFile "rsa-pub.key" WriteMode;
	prvKey <- openFile "rsa-prv.key" WriteMode;
    {- Generate a random number -}
	randGen <- getStdGen;
	let (p,q) = getFactors $ primeList randGen;
    {- Write private and public key in files-}
	hPutStrLn pubKey $ getPubKey (p,q);
	hPutStrLn prvKey $ getPrvKey (p,q);
	hClose pubKey;
	hClose prvKey