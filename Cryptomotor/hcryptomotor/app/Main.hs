module Main where

import qualified RSAHelper                    as Crypt
import RIO
import qualified Data.Text.IO                 as T


main :: IO ()
main = do
  T.putStrLn "Hello, Haskell!"
  Crypt.exampleHashWith "holaa"
