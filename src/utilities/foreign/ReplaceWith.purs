module ReplaceWith where

import Prelude
import Type (Decl, Option, Value)
import Effect (Effect)

-- foreign import replaceWith :: Decl -> Value -> Effect Decl
foreign import replaceWith :: Decl -> Value -> Decl
