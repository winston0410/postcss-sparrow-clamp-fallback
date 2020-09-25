module Regex where

import Prelude
import Data.String.Regex (Regex, test, regex, match)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.String.Regex.Flags (RegexFlags, noFlags, global)
import Type (Decl, Option, Value, Prop)

clampRegex :: Regex
clampRegex = unsafeRegex "^clamp" noFlags

hasClamp :: Value -> Boolean
hasClamp str = test clampRegex str
