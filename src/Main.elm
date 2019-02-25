module Main exposing (main)

import Browser
import Model exposing (Model)
import Update exposing (Msg, init, subscriptions, update)
import Views exposing (view)


main =
    Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }
