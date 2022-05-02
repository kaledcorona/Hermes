module Main where

{- Import modules -}
import qualified RSAHelper                    as Crypt
import qualified RIO                          as R
import qualified Data.Text.IO                 as TIO
import qualified Data.Text                    as TS
import qualified Data.Text.Lazy               as TL
import qualified Data.ByteString              as BS
import qualified Data.ByteString.Lazy.UTF8    as BLU  -- from utf8-string
import qualified Data.ByteString.UTF8         as BSU  -- from utf8-string
import qualified Data.ByteString.Lazy         as BL
import           System.IO
import           Control.Concurrent
import           System.Process
import           Prelude


main :: IO ()
main = do
  -- Important
  hSetBuffering stdout NoBuffering

  -- Read a line from stdin
  line <- TIO.getLine

  -- Convert from Text to String
  let selection = TS.unpack line

  -- Menu 
  menu selection

  -- Emphasize the importance of hSetBuffering :P
  threadDelay 10

  TIO.putStrLn $ TS.pack "Hello, Haskell!"
  Crypt.exampleHashWith $ BSU.fromString "holaa"


menu :: String -> IO ()
menu "1" = callCommand "cd bins; ./hcryptomotor-genkey"
menu "2" = callCommand "echo 'Encriptar documento'"
menu "3" = callCommand "echo 'Desencriptar documento'"
menu "4" = callCommand "echo 'Firmar documento'"
menu "5" = callCommand "echo 'Verificar documento'"
menu _   = callCommand "echo 'Error: opcion no encontrada'"