module Recipe exposing (Amount(..), CanCreateRecipeResult(..), Recipe, RecipeIngredient, RecipeInstruction, allGlassTypes, canBeMadeWith, canCreateRecipe, garnish, ginTonic, glassTypeToString, optionalIngredient, requiredIngredient, sloeGinTonic, tomCollins, french77)

import Ingredient exposing (AlcoholContent(..), Ingredient)
import IngredientType exposing (IngredientType)
import Set


type Amount
    = Cl Float
    | Oz Float
    | Count Int
    | NoAmount


type alias RecipeIngredient =
    { ingredient : Ingredient
    , amount : Amount
    , optional : Bool
    , isGarnish : Bool
    }


type alias RecipeInstruction =
    String


type GlassType
    = Coupe
    | Highball
    | Margarita
    | Martini
    | Flute
    | Rocks
    | Tumbler
    | UnknownGlassType


glassTypeToString : GlassType -> String
glassTypeToString glassType =
    case glassType of
        Coupe ->
            "Coupe"

        Highball ->
            "Highball"

        Margarita ->
            "Margarita"

        Martini ->
            "Martini"

        Flute ->
            "Flute"

        Rocks ->
            "Rocks"

        Tumbler ->
            "Tumbler"

        UnknownGlassType ->
            "UnknownGlassType"


allGlassTypes : Set.Set String
allGlassTypes =
    Set.fromList
        [ glassTypeToString Coupe
        , glassTypeToString Highball
        , glassTypeToString Margarita
        , glassTypeToString Martini
        , glassTypeToString Rocks
        , glassTypeToString Tumbler
        , glassTypeToString UnknownGlassType
        ]


type alias Recipe =
    { name : String
    , ingredients : List RecipeIngredient
    , glassType : GlassType
    , instructions : List RecipeInstruction
    }


requiredIngredient : Amount -> Ingredient -> RecipeIngredient
requiredIngredient amount ingredient =
    { ingredient = ingredient
    , amount = amount
    , optional = False
    , isGarnish = False
    }


optionalIngredient : Amount -> Ingredient -> RecipeIngredient
optionalIngredient amount ingredient =
    { ingredient = ingredient
    , amount = amount
    , optional = True
    , isGarnish = False
    }


garnish : Amount -> Ingredient -> RecipeIngredient
garnish amount ingredient =
    { ingredient = ingredient
    , amount = amount
    , optional = True
    , isGarnish = True
    }


ginTonic : Recipe
ginTonic =
    { name = "Gin and Tonic"
    , ingredients =
        [ requiredIngredient (Cl 5) Ingredient.gin
        , requiredIngredient (Cl 15) Ingredient.tonicWater
        , optionalIngredient (Count 1) Ingredient.limeJuice
        , garnish (Count 1) Ingredient.limeWedge
        ]
    , glassType = Highball
    , instructions = [ "Pour gin into ice-filled glass", "Add tonic water" ]
    }


sloeGinTonic : Recipe
sloeGinTonic =
    { name = "Sloe Gin and Tonic"
    , ingredients =
        [ requiredIngredient (Cl 4) Ingredient.plymouthSloeGin
        , requiredIngredient (Cl 16) Ingredient.simpleSyrup
        , optionalIngredient (Count 1) Ingredient.limeWedge
        ]
    , glassType = Highball
    , instructions =
        [ "Pour gin into an highball glass"
        , "Add tonic water"
        , "Garnish with a lime wedge"
        ]
    }


tomCollins : Recipe
tomCollins =
    { name = "Tom Collins"
    , ingredients =
        [ requiredIngredient (Cl 4.5) Ingredient.gin
        , requiredIngredient (Cl 3) Ingredient.lemonJuice
        , requiredIngredient (Cl 1.5) Ingredient.simpleSyrup
        , optionalIngredient (Cl 6) Ingredient.sodaWater
        ]
    , glassType = Highball
    , instructions =
        [ "Mix the gin, lemon juice and sugar syrup in a tall glass with ice"
        , "Top up with soda water"
        ]
    }


french77 : Recipe
french77 =
    { name = "French 77"
    , ingredients =
        [ requiredIngredient (Cl 3) Ingredient.stGermain
        , requiredIngredient (Cl 3) Ingredient.lemonJuice
        ]
    , glassType = Flute
    , instructions =
        [ "Pour elderflower liqueur (St Germain) and lemon juice into a chilled champagne flute"
        , "Top with champagne. Garnich with a lemon twist"
        ]
    }

{-| True iff recipe can be made using only ingredientsWeHave
-}
canBeMadeWith : List Ingredient -> Recipe -> Bool
canBeMadeWith ingredientsWeHave recipe =
    let
        requiredIngredientTypes : List IngredientType
        requiredIngredientTypes =
            recipe.ingredients
                |> List.filter (not << .optional)
                |> List.map (.ingredient >> .ingredientType)

        availableIngredientTypes : List IngredientType
        availableIngredientTypes =
            ingredientsWeHave
                |> List.map .ingredientType
    in
    requiredIngredientTypes
        |> List.all (\it -> List.member it availableIngredientTypes)


type alias MatchingIngredients =
    Ingredient


type alias MissingIngredient =
    Ingredient


type CanCreateRecipeResult
    = HasAllIngredients (List Ingredient)
    | MissingIngredients (List MatchingIngredients) (List MissingIngredient)


canCreateRecipe : List Ingredient -> Recipe -> CanCreateRecipeResult
canCreateRecipe ingredientsWeHave recipe =
    let
        requiredIngredients : List Ingredient
        requiredIngredients =
            recipe.ingredients
                |> List.filter (not << .optional)
                |> List.map .ingredient

        availableIngredientTypes : List IngredientType
        availableIngredientTypes =
            ingredientsWeHave
                |> List.map .ingredientType

        ( matchingIngredients, missingIngredients ) =
            requiredIngredients
                |> List.partition
                    (\it ->
                        List.member it.ingredientType availableIngredientTypes
                    )
    in
    if List.length missingIngredients == 0 then
        HasAllIngredients matchingIngredients

    else
        MissingIngredients matchingIngredients missingIngredients
