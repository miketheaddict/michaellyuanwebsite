module Msg exposing (..)

import Time
import Material
import Window

import Element.Element as Element exposing (Element, MsgStream)
import Element.ShapeTraffic as ShapeTraffic exposing (ShapeTraffic)

-- Msg -------------------------------------------------------------------------
type Msg
  = Debug String
  | Init Time.Time
  | Tick Time.Time
  | WindowResize Window.Size
  | MDL Material.Msg
  | ShapeMsg (MsgStream ShapeTraffic.UpMsg ShapeTraffic.DownMsg)
  | Empty
