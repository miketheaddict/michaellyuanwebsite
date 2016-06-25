module Model exposing (..)

import Material
import Window
import Task
import Time

import Msg exposing (..)
import Element.Element as Element
import Element.ShapeTraffic as ShapeTraffic exposing (ShapeTraffic)

-- Model -----------------------------------------------------------------------
type alias Model =
  { debug : String
  , mdl : Material.Model
  , shapeTraffic : ShapeTraffic Msg
  , windowSize : Window.Size
  , startTime : Time.Time
  }

init : (Model, Cmd Msg)
init = (
  { debug = "Init-------------------------------------------------------
    |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
  , mdl = Material.model
  , shapeTraffic = ShapeTraffic.init ShapeMsg
  , windowSize = {width = 1920, height = 1080}
  , startTime = 0
  }, Cmd.batch
    [ Task.perform (always <| Msg.WindowResize {width = 1920, height = 1080}) (\size -> Msg.WindowResize size) Window.size
    , Task.perform (always <| Init 0) Init Time.now
    ]
  )
