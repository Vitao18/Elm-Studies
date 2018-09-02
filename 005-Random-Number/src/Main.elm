import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (src, width, height)
import Random

-- Main

main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

-- Model

type alias Model =
    { dieFace : Int
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )

-- Update

type Msg
    = Roll
    | NewFace Int

update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )
        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- View

getImage : Int -> String
getImage n = "dice" ++ (String.fromInt n) ++ ".png"

view : Model -> Html Msg
view model =
    div []
        [ img [ src ("images/" ++ (getImage model.dieFace)), width 300, height 300 ] []
        , button [ onClick Roll ] [ text "Roll" ]
        ]
