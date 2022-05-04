#!/usr/bin/env stack
-- stack --resolver lts-9.3 script
import           Crypto.Hash             (hash, SHA256 (..), Digest)
import           Data.ByteString         (ByteString)
import           Data.Text.Encoding      (encodeUtf8)
import qualified Data.Text.IO            as TIO
import           System.IO               (hFlush, stdout)

main :: IO ()
main = do
  putStr "Enter some text: "
  hFlush stdout
  text <- TIO.getLine
  let bs = encodeUtf8 text
  putStrLn $ "You entered: " ++ show bs
  let digest :: Digest SHA256
      digest = hash bs
  putStrLn $ "SHA256 hash: " ++ show digest