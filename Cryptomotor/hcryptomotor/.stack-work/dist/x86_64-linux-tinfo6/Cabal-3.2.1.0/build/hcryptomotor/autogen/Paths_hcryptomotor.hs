{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_hcryptomotor (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/bin"
libdir     = "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/lib/x86_64-linux-ghc-8.10.7/hcryptomotor-0.1.0.0-96tiUVkj8H6mQp7jj0SCg-hcryptomotor"
dynlibdir  = "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/lib/x86_64-linux-ghc-8.10.7"
datadir    = "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/share/x86_64-linux-ghc-8.10.7/hcryptomotor-0.1.0.0"
libexecdir = "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/libexec/x86_64-linux-ghc-8.10.7/hcryptomotor-0.1.0.0"
sysconfdir = "/home/community/school/semestres/sem6/algebra/challenge/hermes/Cryptomotor/hcryptomotor/.stack-work/install/x86_64-linux-tinfo6/0ede982d3f8e41d7cefbca13c6f922878b5a782887477c6d0108f39e91a3b7a1/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hcryptomotor_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hcryptomotor_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hcryptomotor_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hcryptomotor_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hcryptomotor_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hcryptomotor_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
