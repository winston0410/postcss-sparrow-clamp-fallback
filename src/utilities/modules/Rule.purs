module Rule where

import Prelude
import Type (Decl, Option, Value, Prop, Rule)

createNewRule :: Prop -> Value -> Rule
createNewRule prop value = prop <> ": " <> value <> ";"
