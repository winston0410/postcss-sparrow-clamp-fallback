module Helper where

import Prelude
import Data.Decl
import Data.Config
import Effect (Effect)
import Effect.Console (log)

identity :: forall a. a -> a
identity a = a

createFallback :: String -> Effect Unit
createFallback "minmax" = log "Options is minmax"
createFallback "media" = log "Options is media"
createFallback str = log "This is not accepted"

-- Successfully built

-- createFallback :: String -> Effect Unit
-- createFallback = case _ of
--   "minmax" -> log "Options is minmax"
--   "media" -> log "Options is media"
--   _ -> log "Not"
