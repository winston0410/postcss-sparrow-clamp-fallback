module ReplaceWith where

import Prelude
import Type (Decl, Option, Value)
import Effect (Effect)
-- import Effect.Uncurried (EffectFn2, runEffectFn2)

foreign import replaceWith :: Decl -> Value -> Effect Decl
-- foreign import replaceWith :: EffectFn2 Decl Value Decl
--
-- replaceWithCurried :: Decl -> Value -> Effect Decl
-- replaceWithCurried decl value = runEffectFn2 replaceWith decl value
