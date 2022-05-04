{-# LANGUAGE
    TypeOperators
    , DataKinds

#-}
module Main where

-- Import libraries
import           RIO
import qualified RIO.ByteString         as BS
import qualified RIO.Text               as T 

import           Conduit
import qualified Data.Text.IO as T
import           Options.Generic




data Options w = Options {
    version :: w ::: Bool <?> "Display version information"
    , config :: w ::: Maybe String <?> "Specify a config file"
    }

main :: IO ()
main = putStrLn "Test suite not yet implemented."


