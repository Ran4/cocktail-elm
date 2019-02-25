module Model exposing (Amount(..), GlassType(..), Ingredient, Instruction, Model, Recipe, RecipeIngredient, garnish, optionalIngredient, requiredIngredient)


type alias Ingredient =
    { name : String
    }


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


type alias Instruction =
    String


type GlassType
    = Coupe
    | Tumbler
    | Highball
    | UnknownGlassType


type alias Recipe =
    { name : String
    , ingredients : List RecipeIngredient
    , glassType : GlassType
    , instructions : List Instruction
    }


type alias Model =
    { amount : Int
    , has : List Ingredient
    , canAquire : List Ingredient
    , ingredients : List Ingredient
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
