-- import Effects exposing (Never)
import Gallery exposing (init, view, update)
import StartApp.Simple as StartApp
import Html

-- import Tasks

-- model: Gallery.Model
-- model = init

main: Signal Html.Html
main =
  StartApp.start
    { model = init
    , view = view
    , update = update
    -- , inputs = []
    }

-- main =
--   app.html

-- port tasks : Signal (Task.Task Never ())
-- port tasks =
--   app.tasks
