module Main where

import qualified MyLib                        as Crypt
import RIO
import qualified Data.Text.IO                 as T


main :: IO ()
main = do
  T.putStrLn "Hello, Haskell!"
  Crypt.exampleIncrInPlace
  Crypt.exampleHashWith "holaa"

