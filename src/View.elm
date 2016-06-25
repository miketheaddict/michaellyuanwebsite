module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Color as Color
import Material.Layout as Layout
import Material.Helpers exposing (lift, lift')
import Material.Options as Style
import Material.Scheme as Scheme
import Material.Button as Button

import Msg exposing (..)
import Model exposing (..)
import Element.Element as Element
import Element.ShapeTraffic as ShapeTraffic

view : Model -> Html Msg
view model = Scheme.top <|
  div
    [ style [("width", toString model.windowSize.width), ("height", toString model.windowSize.height)], class "layer" ]
    [ Element.render model.shapeTraffic
    , div [class "layer"]
      [p [class "debug"] [text <| "Debug String: " ++ model.debug ++ "\n\nModel: " ++ (toString model)]]
    ]
