module Main where

{- Import modules -}
import qualified RSAHelper                    as Crypt
import qualified RIO                          as R
import qualified Data.Text.IO                 as TIO
import qualified Data.Text                    as T
import System.IO
import Control.Concurrent
import System.Process
import Prelude


main :: IO ()
main = do
  -- Important
  hSetBuffering stdout NoBuffering

  -- Read a line from stdin
  line <- TIO.getLine

  -- Menu 
  menu line

  -- Emphasize the importance of hSetBuffering :P
  threadDelay 10

  TIO.putStrLn "Hello, Haskell!"
  Crypt.exampleHashWith "holaa"


menu :: (T.Text) -> IO ()
menu ("1" :: T.Text) = callCommand "cd bins; ./hcryptomotor-genkey"
menu ("2" :: T.Text) = callCommand "echo 'Encriptar documento'"
menu ("3" :: T.Text) = callCommand "echo 'Desencriptar documento'"
menu ("4" :: T.Text) = callCommand "echo 'Firmar documento'"
menu ("5" :: T.Text) = callCommand "echo 'Verificar documento'"
menu _ = callCommand "echo 'Error: opcion no encontrada'"