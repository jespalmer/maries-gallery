module Image where

import Effects exposing (Effects, Never)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json
import Task


-- MODEL

type alias Model =
    { imageUrl : String
    }

init : (Model, Effects)
init  =
  ( Model "assets/waiting.gif")

-- UPDATE

-- VIEW
(=>) = (,)


view : Signal.Address Action -> Model -> Html
view address model =
  div [ style [ "width" => "200px" ] ]
    [ h2 [headerStyle] [text "text"]
    , div [imgStyle model.imageUrl] []
    ]


headerStyle : Attribute
headerStyle =
  style
    [ "width" => "200px"
    , "text-align" => "center"
    ]


imgStyle : String -> Attribute
imgStyle url =
  style
    [ "display" => "flex"
    , "width" => "200px"
    , "height" => "200px"
    , "background-position" => "center center"
    , "background-size" => "cover"
    , "background-image" => ("url('" ++ url ++ "')")
    ]


-- EFFECTS

randomUrl : String
randomUrl =
  Http.url "https://www.mariesglutenfree.com/ajax/products"


decodeUrl : Json.Decoder String
decodeUrl =
  Json.at ["image", "name"] Json.string
