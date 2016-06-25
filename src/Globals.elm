module Globals exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Scheme as Scheme
import Window
import Time
import Task
import AnimationFrame

-- Globals Variables -----------------------------------------------------------
materialColors : List String
materialColors = ["#f44336", "#E91E63", "#9C27B0", "#673AB7", "#3F51B5", "#2196F3", "#03A9F4", "#00BCD4", "#009688", "#4CAF50", "#8BC34A", "#CDDC39", "#FFEB3B", "#FFC107", "#FF9800", "#FF5722"{-, "#795548", "#9E9E9E", "#607D8B"-}]



-- Msg -------------------------------------------------------------------------
type Msg
  = Debug String
  | Init Time.Time
  | Tick Time.Time
  | WindowResize Window.Size
  | MDL Material.Msg
  | Empty



-- Model -----------------------------------------------------------------------
type alias Model =
  { debug : String
  , mdl : Material.Model
  , windowSize : Window.Size
  , startTime : Time.Time
  }

init : (Model, Cmd Msg)
init = (
  { debug = "Init"
  , mdl = Material.model
  , windowSize = {width = 1920, height = 1080}
  , startTime = 0
  }, Cmd.batch
    [ Task.perform (always <| Init 0) Init Time.now
    ]
  )



-- Update ----------------------------------------------------------------------
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Debug str -> ({model | debug = str}, Cmd.none)
    Init time -> ({model | startTime = time}, Cmd.none)
    MDL materialMsg -> Material.update MDL materialMsg model
    Tick time -> (model, Cmd.none)
    WindowResize size -> (model, Cmd.none)
    _ -> (model, Cmd.none)



-- View ------------------------------------------------------------------------
view : Model -> Html Msg
view model = Scheme.top <|
  div
    [ style [("width", toString model.windowSize.width), ("height", toString model.windowSize.height), ("backgroundColor", "#03A9F4")], class "layer"]
    [ div [class "layer"]
      [p [class "debug"] [text <| "Debug String: " ++ model.debug ++ "\n\nModel: " ++ (toString model)]]
    ]



-- Subs ------------------------------------------------------------------------
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ AnimationFrame.times Tick, Window.resizes WindowResize]
