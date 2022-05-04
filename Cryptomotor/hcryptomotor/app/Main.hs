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
import qualified Data.ByteArray               as BA
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

  -- Timer
  threadDelay 10



menu :: String -> IO ()
menu "1" = callCommand "./.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/bin/hcryptomotor-genkey"
menu "2" = callCommand "echo 'Encriptar documento'"
menu "3" = callCommand "echo 'Desencriptar documento'"
menu "4" = callCommand "./bins/sha384sum -t ./test/testfiles/test.pdf | ./.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/bin/hcryptomotor-sign"
menu "5" = callCommand "echo 'Verificar documento'"
menu _   = callCommand "echo 'Error: opcion no encontrada'"