module Prop where

import Prelude
import Type (Decl, Option, Value, Prop, Rule)

getDeclProp :: Decl -> Prop
getDeclProp = _."prop"
