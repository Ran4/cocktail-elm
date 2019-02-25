module Update exposing (Msg(..), getPossibleRecipes, init, subscriptions, update)

import Model exposing (Amount(..), GlassType(..), Ingredient, Model, Recipe, garnish, optionalIngredient, requiredIngredient)


type Msg
    = RemoveIngredientFromHas Ingredient
    | AddIngredientFromCanAquire Ingredient
    | AddIngredientFromIngredients Ingredient
    | RemoveIngredientFromCanAquire Ingredient


removeIngredient ingredientToRemove ingredientList =
    ingredientList
        |> List.filter (\i -> i.name /= ingredientToRemove.name)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RemoveIngredientFromHas ingredientToRemove ->
            ( { model
                | has =
                    model.has |> removeIngredient ingredientToRemove
                , canAquire = ingredientToRemove :: model.canAquire
              }
            , Cmd.none
            )

        AddIngredientFromCanAquire ingredientToAdd ->
            ( { model
                | canAquire =
                    model.canAquire |> removeIngredient ingredientToAdd
                , has = ingredientToAdd :: model.has
              }
            , Cmd.none
            )

        AddIngredientFromIngredients ingredientToAdd ->
            ( { model
                | ingredients =
                    model.ingredients |> removeIngredient ingredientToAdd
                , has = ingredientToAdd :: model.has
              }
            , Cmd.none
            )

        RemoveIngredientFromCanAquire ingredientToRemove ->
            ( { model
                | canAquire =
                    model.canAquire |> removeIngredient ingredientToRemove
                , ingredients = ingredientToRemove :: model.ingredients
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


sloeGin =
    { name = "Sloe Gin" }


gin =
    { name = "Gin" }


tonicWater =
    { name = "Tonic Water" }


simpleSyrup =
    { name = "Simple Syrup" }


tripleSec =
    { name = "Triple Sec" }


limeJuice =
    { name = "Lime Juice" }


limeWedge =
    { name = "Lime Wedge" }


ginTonic : Recipe
ginTonic =
    { name = "Gin and Tonic"
    , ingredients =
        [ requiredIngredient (Cl 5) gin
        , requiredIngredient (Cl 15) tonicWater
        , optionalIngredient (Count 1) limeJuice
        , garnish (Count 1) limeWedge
        ]
    , glassType = Highball
    , instructions = [ "Pour gin into ice-filled glass", "Add tonic water" ]
    }


allRecipes : List Recipe
allRecipes =
    [ ginTonic ]


canMakeRecipe : Model -> Recipe -> Bool
canMakeRecipe model recipe =
    True


getPossibleRecipes : Model -> List Recipe
getPossibleRecipes model =
    allRecipes
        |> List.filter (canMakeRecipe model)


initialHas : List Ingredient
initialHas =
    [ sloeGin
    , gin
    , tonicWater
    ]


initialCanAquire : List Ingredient
initialCanAquire =
    [ simpleSyrup
    ]


initialIngredients : List Ingredient
initialIngredients =
    [ tripleSec
    ]


initialModel : Model
initialModel =
    { amount = 0
    , has = initialHas
    , canAquire = initialCanAquire
    , ingredients = initialIngredients
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel
    , Cmd.none
    )
