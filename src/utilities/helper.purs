-- Terminology:
-- ***
-- declaration:
-- a {
--   font-size: clamp(20px, 30px, 40px);
-- }
-- rule: font-size: clamp(20px, 30px, 40px);
-- prop: font-size
-- value: clamp(20px, 30px, 40px)
-- subValue: [20px, 30px, 40px]
-- ***

module Helper where

import Prelude

import Data.Array (index)
import Data.Array.NonEmpty (toArray)
import Data.Array.NonEmpty.Internal (NonEmptyArray)
import Data.Maybe (Maybe(..), fromJust)
import Data.Newtype (unwrap)
import Data.String.Regex (Regex, test, regex, match)
import Data.String.Regex.Flags (RegexFlags, noFlags, global)
import Data.String.Regex.Unsafe (unsafeRegex)
import Effect (Effect)
import Effect.Console (log)
import Partial.Unsafe (unsafePartial)
import Prop (getDeclProp)
import Regex (clampRegex, hasClamp)
import ReplaceWith (replaceWith)
import Rule (createNewRule)
import Type (Decl, Option, Value, Prop, Rule)
import Value (createNewValue, getDeclValue)

filterDeclByValue :: Decl -> Option -> Effect Decl
filterDeclByValue decl option = if decl # getDeclValue # hasClamp
  then createFallback option decl
  else pure decl

-- createFallback { fallback: "minmax" } decl = decl `replaceWith` (decl # getDeclValue # getSubValues # createNewValueWithMinMax)
createFallback :: Option -> Decl -> Effect Decl
createFallback { fallback: "minmax" } decl = decl `replaceWith` ( (getDeclProp decl) `createNewRule` (createNewValue { fallback: "minmax" } decl) )
-- createFallback { fallback: "media" } decl = decl `replaceWith` ( { fallback: "media" } `createNewValue` decl)
createFallback option decl = pure decl
