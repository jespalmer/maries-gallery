-- model: image url, image id, with product name beneath and checkbox
-- actions: toggle
-- updates: the boolean state of the image, checked or unchecked
-- view: show an image url, with attributes of width and heights 300px; beneath that image url display the product name and beneath that display a button

module Image where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (length)

-- MODEL

type alias Model =
  { imgUrl: String
  , imgName: String
  , imgId: Int
  , imgCheck: Bool
  }

defaultUrl: String
defaultUrl = "http://s3.amazonaws.com/maries_bakery/coming_soon2-large.jpg"

init : String -> String -> Int -> Model
init url name id =
  let
    actualUrl =
      if length url == 0 then
        defaultUrl
      else
        url
  in
    {
      imgUrl = actualUrl,
      imgName = name,
      imgId = id,
      imgCheck = False
    }

-- UPDATE

type Action = Toggle
update : Action -> Model -> Model
update action model =
  case action of
    Toggle ->
      { model | imgCheck = not model.imgCheck }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let
    btnText =
      if model.imgCheck then
        "Deleting"
      else
        "Keeping"
  in
    div [ style [("width", "300px")] ]
      [h2 [headerStyle] [text model.imgName]
      , div [imageStyle model.imgUrl] []
      , button [btnStyle, onClick address Toggle] [text btnText]
      ]

headerStyle : Attribute
headerStyle =
  style
    [ ("width", "300px")
    , ("text-align", "center")
    ]

imageStyle : String -> Attribute
imageStyle url =
  style
    [ ("display", "inline-block")
    , ("width" , "300px")
    , ("height" , "300px")
    , ("background-position" , "center center")
    , ("background-size" , "cover")
    , ("background-image" , ("url('" ++ url ++ "')"))
    ]

btnStyle : Attribute
btnStyle =
  style
    [ ("display", "inline-block")
    , ("width" , "200px")
    , ("padding", "8px")
    , ("color", "purple")
    , ("border", "3px solid purple")
    , ("text-align", "center")
    , ("outline", "none")
    , ("text-decoration", "none")
    , ("transition", "background-color 0.2s ease-out, color 0.2s ease-out")
    ]
