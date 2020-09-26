module Value where

import Prelude

import Data.Array (index)
import Data.Array.NonEmpty (toArray)
import Data.Array.NonEmpty.Internal (NonEmptyArray)
import Data.Maybe (Maybe(..), fromJust, fromMaybe)
import Data.Either (hush)
import Data.Traversable (sequence)
import Data.Newtype (unwrap)
import Data.String.Regex (Regex, test, regex, match)
import Data.String.Regex.Flags (RegexFlags, noFlags, global)
import Data.String.Regex.Unsafe (unsafeRegex)
import Effect (Effect)
import Effect.Console (log)
import Partial.Unsafe (unsafePartial)
import Regex (clampRegex, hasClamp)
import Prop (getDeclProp)
import Rule (createNewRule)
import ReplaceWith (replaceWith)
import Type (Decl, Option, Value, Prop, Rule)

unwrapString :: Maybe String -> String
unwrapString (Just n) = n
unwrapString Nothing = ""

getSubValues :: String -> Array String
getSubValues = fromMaybe [] <<< go
  where
    go :: String -> Maybe (Array String)
    go str = do
      regExp <- hush $ regex "\\d[\\w%]*" global
      result <- match regExp str
      nonEArr <- sequence result
      pure $ toArray nonEArr

constructValue :: Array String -> Value
constructValue arr = "max(" <> firstValue <> ", min(" <> secondValue <> ", " <> thirdValue <> "))"
  where
    getElementByIndex :: Int -> Maybe String
    getElementByIndex num = arr `index` num

    firstValue :: String
    firstValue = getElementByIndex 0 # unwrapString

    secondValue :: String
    secondValue = getElementByIndex 1 # unwrapString

    thirdValue :: String
    thirdValue = getElementByIndex 2 # unwrapString

-- getSubValues :: String -> Maybe (NonEmptyArray (Maybe String))
-- getSubValues str = match valueRegex str

getDeclValue :: Decl -> Value
getDeclValue = _."value"

-- Unfinished
createNewValue :: Option -> Decl -> Value
createNewValue { fallback: "minmax"} decl = decl # getDeclValue # getSubValues # constructValue
createNewValue { fallback: "media"} decl = decl # getDeclValue
createNewValue _ decl = "You need to use the correct fallback value"
