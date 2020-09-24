module Helper where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Data.Maybe (Maybe(..), fromJust)
import Data.Array (index)
import Data.Array.NonEmpty.Internal (NonEmptyArray)
import Data.String.Regex (Regex, test, regex, match)
import Data.String.Regex.Flags (RegexFlags, noFlags, global)
import Data.String.Regex.Unsafe (unsafeRegex)
-- import Debug.Trace (trace)
import Partial.Unsafe (unsafePartial)

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

unwrapMaybe :: forall a. Maybe a -> a
unwrapMaybe value = case value of
  Just x -> x
  _ -> x

-- Why not handle this by default? Is this the correct way to handle Maybe?
-- unwrapJust :: Just ->

-- splitClamp :: Decl -> Array String
-- splitClamp = decl # getDeclValue #

-- Unfinished
createNewValue :: Option -> Array String -> Value
createNewValue { fallback: "minmax"} arr = "Hello"
createNewValue { fallback: "media"} arr = "World"
createNewValue _ arr = "World"

createNewValueWithMinMax :: Array String -> Value
createNewValueWithMinMax = createNewValue { fallback: "minmax"}

createNewValueWithMedia :: Array String -> Value
createNewValueWithMedia = createNewValue { fallback: "media"}

filterDeclByValue :: Decl -> Option -> Effect Decl
filterDeclByValue decl option = if decl # getDeclValue # hasClamp
  then createFallback option decl
  else pure decl

createFallback :: Option -> Decl -> Effect Decl
-- createFallback { fallback: "minmax" } decl = decl `replaceWith` (decl # getDeclValue # getValues # createNewValueWithMinMax)
createFallback { fallback: "media" } decl = decl `replaceWith` "font-size: world;"
createFallback option decl = pure decl
