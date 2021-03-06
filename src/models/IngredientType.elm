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
    | ElderflowerLiqueur
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
    | SodaWater
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

        ElderflowerLiqueur ->
            "Elderflower Liqueur"

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

        SodaWater ->
            "Soda water"

        AgaveNectar ->
            "Agave nectar"

        Cherry ->
            "Cherry"
