-- File "./Hs.hs"

import Control.Concurrent                                                   
import System.IO

main :: IO()
main = do
  -- Important
  hSetBuffering stdout NoBuffering

  -- Read a line
  line <- getLine

  -- parse the line and add one and print it back
  putStrLn (show (read line + 1))

  -- Emphasize the importance of hSetBuffering :P
  threadDelay 10000000