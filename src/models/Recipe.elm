module Recipe exposing (Amount(..), Recipe, RecipeIngredient, RecipeInstruction, garnish, ginTonic, optionalIngredient, requiredIngredient)

import Ingredient exposing (AlcoholContent(..), Ingredient)


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
    | Rocks
    | Tumbler
    | UnknownGlassType


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
