module Helper where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Data.String.Regex (Regex, test, regex)
import Data.String.Regex.Flags (RegexFlags, noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)

-- data Decl = DR { value :: String }
type Decl = { value :: String }
type Option = { fallback :: String }

clampRegex :: Regex
clampRegex = unsafeRegex "^clamp" noFlags

hasClamp :: String -> Boolean
hasClamp str = test clampRegex str

getValue :: Decl -> String
getValue obj = obj."value"

filterDeclByValue :: Decl -> Option -> Decl
filterDeclByValue decl option = if decl # getValue # hasClamp
  then createFallback decl option
  else decl

createFallback :: Decl -> Option -> Decl
-- createFallback { fallback: "minmax" } = log "Options is minmax"
-- createFallback { fallback: "media" } = log "Options is media"
createFallback decl option = decl
