-- model: image list
-- view: display left all the images in the list, display on right filtered image id and image name as strings
-- update: bring in actions from Image
-- effects: decode url, image name, and id

module Gallery where

-- import Effects exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
-- import Http
-- import Json.Decode as Json

import Image

-- MODEL

type alias Model =
  { imgList: List Image.Model
  }

type Action = Modify Int Image.Action

init : Model
init =
  {imgList =
    [ Image.init "" "Black Forest Cupcakes" 0
      , Image.init "" "Cinnamon Rolls Ganache" 1
      , Image.init "https://s3.amazonaws.com/maries_bakery/paleo_cake_germanchocolate1.jpg" "Cinnamon Rolls Ganache" 2
    ]}

-- UPDATE

update: Action -> Model -> Model
update action model =
  case action of
    Modify id action->
      let updateImage imageModel =
              if imageModel.imgId == id then
                  Image.update action imageModel
              else
                  imageModel
      in
          { model | imgList = List.map updateImage model.imgList }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [ style [ ("display", "flex"), ("flex-wrap", "wrap") ] ]
    (List.map (elementView address) model.imgList)

elementView : Signal.Address Action -> Image.Model -> Html
elementView address model =
    Image.view (Signal.forwardTo address (Modify model.imgId)) model

-- -- EFFECTS
-- SingleUrl : String -> String
-- SingleUrl  =
--   Http.url "https://www.mariesglutenfree.com/ajax/products"
--
-- decodeUrl : Json.Decoder String
-- decodeUrl =
--   Json.at ["id", "image", "name"] Json.string
