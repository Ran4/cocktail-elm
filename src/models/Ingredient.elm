module Ingredient exposing
    ( AlcoholContent(..)
    , Ingredient
    , gin
    , limeJuice
    , limeWedge
    , plymouthSloeGin
    , simpleSyrup
    , tonicWater
    , tripleSec
    )

import IngredientType exposing (IngredientType)


type AlcoholContent
    = ABV Float -- Must not be 0, use AlcoholContent.NonAlcoholic instead
    | ABW Float -- Must not be 0, use AlcoholContent.NonAlcoholic instead
    | NonAlcoholic


type alias Ingredient =
    { name : String
    , ingredientType : IngredientType
    , brand : Maybe String
    , alcoholContent : AlcoholContent
    , description : Maybe String
    }


alcoholicDrinkIngredient : IngredientType.IngredientType -> String -> Ingredient
alcoholicDrinkIngredient ingredientType name =
    { name = name
    , ingredientType = ingredientType
    , brand = Nothing
    , alcoholContent = ABV 40
    , description = Nothing
    }


withABV : Float -> Ingredient -> Ingredient
withABV abv ingredient =
    { ingredient | alcoholContent = ABV abv }


nonAlcoholicIngredient : IngredientType -> String -> Ingredient
nonAlcoholicIngredient ingredientType name =
    { name = name
    , ingredientType = ingredientType
    , brand = Nothing
    , alcoholContent = NonAlcoholic
    , description = Nothing
    }


defaultIngredient : Ingredient
defaultIngredient =
    { name = "Ingredient name"
    , ingredientType = IngredientType.SloeGin
    , brand = Nothing
    , alcoholContent = ABV 40
    , description = Nothing
    }


plymouthSloeGin : Ingredient
plymouthSloeGin =
    { name = "Sloe Gin"
    , ingredientType = IngredientType.SloeGin
    , brand = Just "Plymouth"
    , alcoholContent = ABV 26
    , description = Nothing
    }


gin : Ingredient
gin =
    alcoholicDrinkIngredient IngredientType.Gin "Gin"
        |> withABV 40


tonicWater : Ingredient
tonicWater =
    nonAlcoholicIngredient IngredientType.TonicWater "Tonic Water"


simpleSyrup : Ingredient
simpleSyrup =
    nonAlcoholicIngredient IngredientType.SimpleSyrup "Simple syrup"


tripleSec : Ingredient
tripleSec =
    alcoholicDrinkIngredient IngredientType.TripleSec "Triple Sec"
        |> withABV 40


limeJuice : Ingredient
limeJuice =
    nonAlcoholicIngredient IngredientType.Lime "Lime Juice"


limeWedge : Ingredient
limeWedge =
    nonAlcoholicIngredient IngredientType.Lime "Lime Wedge"
