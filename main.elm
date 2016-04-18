
import Gallery exposing (init, view, update)
import StartApp.Simple as StartApp
import Html

main: Signal Html.Html
main =
  StartApp.start
    { model = init
    , view = view
    , update = update
    }
