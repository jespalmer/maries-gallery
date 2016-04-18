-- model: image url, image id, with product name beneath and checkbox
-- actions: toggle
-- updates: the boolean state of the image, checked or unchecked
-- view: show an image url, with attributes of width and heights 300px; beneath that image url display the product name text-align centered with and beneath that display a checkbox

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
        "Kill me"
      else
        "Keep me"
  in
    div [ style [("width", "300px")] ]
      [h2 [headerStyle] [text model.imgName]
      , div [imageStyle model.imgUrl] []
      , button [onClick address Toggle] [text btnText]
      ]

headerStyle : Attribute
headerStyle =
  style
    [ ("width", "200px")
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
