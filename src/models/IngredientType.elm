module IngredientType exposing (IngredientType(..))


type IngredientType
    = Gin
    | SloeGin
    | Bourbon
    | Tequila
    | TripleSec
    | Vodka
    | DarkRum
    | LightRum
    | MaraschinoLiqueur
    | CremeDeViolette
    | OrangeSlice
    | OrangeJuice
    | TonicWater
    | SimpleSyrup
    | TranberryJuice
    | Lemon
    | Lime
    | LimeCordial -- e.g. Rose's Lime
    | AgaveNectar
    | Cherry


toString : IngredientType -> String
toString ingredientType =
    case ingredientType of
        Gin ->
            "Gin"

        SloeGin ->
            "Sloe Gin"

        Bourbon ->
            "Bourbon"

        Tequila ->
            "Tequila"

        TripleSec ->
            "Triple Sec"

        Vodka ->
            "Vodka"

        DarkRum ->
            "Dark Rum"

        LightRum ->
            "Light Rum"

        MaraschinoLiqueur ->
            "Maraschino Liqueur"

        CremeDeViolette ->
            "Crème de Violette"

        OrangeSlice ->
            "Orange slice"

        OrangeJuice ->
            "Orange Juice"

        TonicWater ->
            "Tonic Water"

        SimpleSyrup ->
            "Simple Syrup"

        TranberryJuice ->
            "Tranberry Juice"

        Lemon ->
            "Lemon"

        Lime ->
            "Lime"

        -- e.g. Rose's Lime
        LimeCordial ->
            "Lime Cordial"

        AgaveNectar ->
            "Agave nectar"

        Cherry ->
            "Cherry"
