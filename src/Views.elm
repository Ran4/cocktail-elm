module Views exposing (view)

import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Ingredient exposing (Ingredient)
import Model exposing (Model)
import Recipe exposing (Amount(..), Recipe, RecipeIngredient, RecipeInstruction)
import Update exposing (Msg(..), getPossibleRecipes)


heading : String -> Html Msg
heading label =
    div
        [ style "color" "#a2a2a2"
        , style "font-size" "20px"
        , style "font-weight" "bold"
        , style "border-style" "solid"
        , style "border-width" "2px"
        , style "border-color" "black"
        ]
        [ text label ]


buttonStyle color =
    [ style "background-color" color
    , style "color" "white"
    , style "padding" "5px"
    , style "border-radius" "0.5em"
    ]


customButton bgColor label onclick =
    span (onClick onclick :: buttonStyle bgColor) [ text label ]


hasIngredientLine : Ingredient -> Html Msg
hasIngredientLine ingredient =
    div
        [ style "color" "#f0f0f0"
        , style "padding" "2px"
        ]
        [ text ingredient.name
        , customButton "red" "Remove" (RemoveIngredientFromHas ingredient)
        ]


canAquireLine : Ingredient -> Html Msg
canAquireLine ingredient =
    div
        [ style "color" "#f0f0f0"
        , style "padding" "2px"
        ]
        [ text ingredient.name
        , customButton "red" "Remove" (RemoveIngredientFromCanAquire ingredient)
        , customButton "green" "Add" (AddIngredientFromCanAquire ingredient)
        ]


ingredientsLine : Ingredient -> Html Msg
ingredientsLine ingredient =
    div
        [ style "color" "#f0f0f0"
        , style "padding" "2px"
        ]
        [ text ingredient.name
        , customButton "green" "Add" (AddIngredientFromIngredients ingredient)
        ]


hasSection : Model -> Html Msg
hasSection model =
    div [] <|
        heading "Has"
            :: (model.has |> List.map hasIngredientLine)


canAquireSection : Model -> Html Msg
canAquireSection model =
    div [] <|
        heading "Can Aquire"
            :: (model.canAquire |> List.map canAquireLine)


ingredientsSection : Model -> Html Msg
ingredientsSection model =
    div [] <|
        heading "Ingredients"
            :: (model.ingredients |> List.map ingredientsLine)


viewRecipeIngredient : RecipeIngredient -> Html Msg
viewRecipeIngredient { amount, ingredient, isGarnish } =
    let
        garnishSpan =
            if isGarnish then
                span [ style "color" "#bfffbf" ] [ text "Garnish: " ]

            else
                text ""

        amountString =
            case amount of
                Cl clFloat ->
                    String.fromFloat clFloat ++ " cl "

                Oz ozFloat ->
                    String.fromFloat ozFloat ++ " oz "

                Count count ->
                    case count of
                        0 ->
                            "Zero "

                        1 ->
                            ""

                        2 ->
                            "Two "

                        3 ->
                            "Three "

                        4 ->
                            "Four "

                        n ->
                            String.fromInt n ++ " "

                NoAmount ->
                    " "
    in
    div
        []
        [ garnishSpan
        , span [ style "color" "red" ] [ text amountString ]
        , span [ style "color" "white" ] [ text ingredient.name ]
        ]


viewInstructionLine : RecipeInstruction -> Html Msg
viewInstructionLine recipeInstruction =
    div [] [ text recipeInstruction ]


viewRecipe : Recipe -> Html Msg
viewRecipe recipe =
    let
        labelAndStar =
            div [ style "color" "#cf2020" ] [ text recipe.name ]

        amounts =
            div [] (List.map viewRecipeIngredient recipe.ingredients)

        instructions =
            div [ style "color" "white" ] (List.map viewInstructionLine recipe.instructions)
    in
    div [] [ labelAndStar, amounts, instructions ]


possibleDrinksSection : List Recipe -> Html Msg
possibleDrinksSection possibleRecipes =
    div [] <|
        heading "Possible drinks"
            :: List.map viewRecipe possibleRecipes


leftSide : Model -> Html Msg
leftSide model =
    div [ style "grid-column-start" "1" ]
        [ hasSection model
        , canAquireSection model
        , ingredientsSection model
        ]


middleSide : Model -> Html Msg
middleSide model =
    div [ style "grid-column-start" "2" ]
        [ possibleDrinksSection (getPossibleRecipes model) ]


rightSide : Model -> Html Msg
rightSide model =
    div [ style "grid-column-start" "3" ] [ text "Right side" ]


topSection : Html Msg
topSection =
    div [ style "font-size" "3em" ] [ text "Cocktail recommender" ]


midSection : Model -> Html Msg
midSection model =
    div
        [ style "display" "grid"
        , style "background-color" "#0f0f0f"
        ]
        [ leftSide model
        , middleSide model
        , rightSide model
        ]


footer : Html Msg
footer =
    div [] [ text "Made in elm" ]


view : Model -> Html Msg
view model =
    div []
        [ topSection
        , midSection model
        , footer
        ]
