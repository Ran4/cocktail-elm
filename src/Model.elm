module Model exposing (Model)

import Ingredient exposing (Ingredient)


type alias Model =
    { amount : Int
    , has : List Ingredient
    , canAquire : List Ingredient
    , ingredients : List Ingredient
    }
