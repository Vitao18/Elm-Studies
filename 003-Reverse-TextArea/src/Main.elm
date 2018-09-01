import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- Main

main =
    Browser.sandbox { init = init, update = update, view = view }


-- Model

type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }

-- Update

type Msg =
    Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }

-- View

view : Model -> Html Msg
view model =
    div []
      [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
      , div [] [ text (String.reverse model.content) ]
      ]
      
