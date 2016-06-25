import Html.App

-- My Modules
import Model exposing (..)
import View exposing (..)
import Update exposing (..)

main : Program Never
main =
    Html.App.program
        { init = init --defined in Model.elm
        , view = view
        , update = update
        , subscriptions = subscriptions --defined in Update.elm
        }
