module Update exposing (..)

import AnimationFrame
import Material
import Window

import Msg exposing (..)
import Model exposing (Model)
import Element.Element as Element exposing (Element)
import Element.ShapeTraffic as ShapeTraffic exposing (ShapeTraffic)

-- Update ----------------------------------------------------------------------
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Debug str -> ({model | debug = str}, Cmd.none)
    Init time -> ({model | startTime = time}, Cmd.none) `shapeTrafficUpdater` (ShapeTraffic.Init time)
    MDL materialMsg -> Material.update MDL materialMsg model
    Tick time -> (model, Cmd.none) `shapeTrafficUpdater` (ShapeTraffic.Tick time)
    WindowResize size -> (model, Cmd.none) `shapeTrafficUpdater` (ShapeTraffic.WindowResize (toFloat size.width) (toFloat size.height))
    ShapeMsg msgStream ->
      case msgStream of
        Element.Up msg ->
          case msg of
            ShapeTraffic.NoMsg -> ({model | debug = "asdf"}, Cmd.none)
            --_ -> (model, Cmd.none)
        Element.Down msg -> (model, Cmd.none) `shapeTrafficUpdater` msg
    _ -> (model, Cmd.none)

shapeTrafficUpdater : (Model, Cmd Msg) -> ShapeTraffic.DownMsg -> (Model, Cmd Msg)
shapeTrafficUpdater old msg =
  let
    (model, cmdMsg) = old
    (newShapes, commands) = Element.update msg model.shapeTraffic
  in
    ({model | shapeTraffic = newShapes}, Cmd.batch [cmdMsg, commands])

-- Subs ------------------------------------------------------------------------
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ AnimationFrame.times Tick, Window.resizes Msg.WindowResize]
