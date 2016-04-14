module Gallery where

import Effects exposing (Effects)
import Html exposing (..)
import Html.Attributes exposing (..)

import Image


-- MODEL

type alias Model =
    { left : Image.Model
    , right : Image.Model
    }


init : String -> String -> (Model, Effects Action)
init leftTopic rightTopic =
  let
    (left, leftFx) = Image.init leftTopic
    (right, rightFx) = Image.init rightTopic
  in
    ( Model left right
    , Effects.batch
        [ Effects.map Left leftFx
        , Effects.map Right rightFx
        ]
    )


-- UPDATE

type Action
    = Left Image.Action
    | Right Image.Action


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Left act ->
      let
        (left, fx) = Image.update act model.left
      in
        ( Model left model.right
        , Effects.map Left fx
        )

    Right act ->
      let
        (right, fx) = Image.update act model.right
      in
        ( Model model.left right
        , Effects.map Right fx
        )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [ style [ ("display", "flex") ] ]
    [ Image.view (Signal.forwardTo address Left) model.left
    , Image.view (Signal.forwardTo address Right) model.right
    ]
