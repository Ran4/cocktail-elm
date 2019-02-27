module Update exposing (Msg(..), getPossibleRecipes, init, subscriptions, update)

import Ingredient exposing (AlcoholContent(..), Ingredient)
import IngredientType
import Model exposing (Model)
import Recipe exposing (Recipe)


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


allRecipes : List Recipe
allRecipes =
    [ Recipe.ginTonic ]


canMakeRecipe : Model -> Recipe -> Bool
canMakeRecipe model recipe =
    True


getPossibleRecipes : Model -> List Recipe
getPossibleRecipes model =
    allRecipes
        |> List.filter (canMakeRecipe model)


initialHas : List Ingredient
initialHas =
    [ Ingredient.plymouthSloeGin
    , Ingredient.gin
    , Ingredient.tonicWater
    ]


initialCanAquire : List Ingredient
initialCanAquire =
    [ Ingredient.simpleSyrup
    ]


initialIngredients : List Ingredient
initialIngredients =
    [ Ingredient.tripleSec
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
