module Update exposing (Msg(..), canCreateRecipeResults, getPossibleRecipes, init, subscriptions, update)

import Ingredient exposing (AlcoholContent(..), Ingredient)
import IngredientType
import Model exposing (Model)
import Recipe exposing (CanCreateRecipeResult, Recipe, canCreateRecipe, glassTypeToString)
import Set


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
    [ Recipe.ginTonic
    , Recipe.sloeGinTonic
    ]


canMakeRecipe : List Ingredient -> Set.Set String -> Recipe -> Bool
canMakeRecipe ingredients availableGlassTypes recipe =
    let
        hasIngredients =
            recipe |> Recipe.canBeMadeWith ingredients

        hasCorrectGlasses =
            Set.member (glassTypeToString recipe.glassType) availableGlassTypes
    in
    hasIngredients && hasCorrectGlasses


getPossibleRecipes : Model -> List Recipe
getPossibleRecipes model =
    allRecipes
        |> List.filter (canMakeRecipe model.has Recipe.allGlassTypes)


canCreateRecipeResults : Model -> List ( Recipe, CanCreateRecipeResult )
canCreateRecipeResults model =
    allRecipes
        |> List.map (\recipe -> ( recipe, canCreateRecipe model.has recipe ))


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
