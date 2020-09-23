module Helper where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Data.Maybe (Maybe, fromJust)
import Data.Array.NonEmpty.Internal (NonEmptyArray)
import Data.String.Regex (Regex, test, regex, match)
import Data.String.Regex.Flags (RegexFlags, noFlags, global)
import Data.String.Regex.Unsafe (unsafeRegex)
import Type (Decl, Option, Value, Prop)
import ReplaceWith (replaceWith)

clampRegex :: Regex
clampRegex = unsafeRegex "^clamp" noFlags

hasClamp :: Value -> Boolean
hasClamp str = test clampRegex str

valueRegex :: Regex
valueRegex = unsafeRegex "\\d[\\w%]*" global

getValues :: String -> Maybe (NonEmptyArray (Maybe String))
getValues str = match valueRegex str

getDeclValue :: Decl -> Value
getDeclValue = _."value"

getDeclProp :: Decl -> Prop
getDeclProp = _."prop"

-- Why not handle this by default? Is this the correct way to handle Maybe?
-- unwrapJust :: Just ->

-- splitClamp :: Decl -> Array String
-- splitClamp = decl # getDeclValue #

-- filterDeclByValue :: Decl -> Option -> Effect Decl
filterDeclByValue :: Decl -> Option -> Decl
filterDeclByValue decl option = if decl # getDeclValue # hasClamp
  then createFallback decl option
  else decl

-- createFallback :: Decl -> Option -> Effect Decl
createFallback :: Decl -> Option -> Decl
createFallback decl { fallback: "minmax" } = replaceWith decl "font-size: hello;"
createFallback decl { fallback: "media" } = replaceWith decl "font-size: world;"
createFallback decl option = decl
