module Helper where

import Prelude
-- import Effect (Effect)
-- import Effect.Console (log)
import Data.String.Regex (test, regex)
import Data.String.Regex.Flags (noFlags)

-- createFallback :: String -> Effect Unit
-- createFallback "minmax" = log "Options is minmax"
-- createFallback "media" = log "Options is media"
-- createFallback str = log "This is not accepted"

hasClamp :: String -> Boolean
hasClamp = test $ regex "clamp" noFlags

-- hasClamp :: Regex -> String -> Boolean
-- hasClamp value = test /clamp/ value
