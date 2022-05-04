import qualified Data.ByteArray as BA
import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import Prelude

main :: IO ()
main = do
  B.writeFile "test.txt" "This is a test"
  byteString <- B.readFile "test.txt"
  let bytes :: BA.Bytes
      bytes = BA.convert byteString
  print bytes