import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Task
import Time


-- Main

main =
    Browser.element
        { init = init
        , view = view
        , update  = update
        , subscriptions = subscriptions
        }

-- Model

type alias Model =
    { deadLine : Int
    , elapsed : Int
    , paused : Bool
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1500 0 True
    , Cmd.none
    )

-- Update

type Msg
    = Tick Time.Posix
    | ToggleStatus
    | Reset

update : Msg -> Model -> ( Model, Cmd Msg )    
update msg model =
    case msg of
        Tick _ ->
           ({ model | elapsed = model.elapsed + 1 }
           , Cmd.none
           )
        ToggleStatus ->
           ({ model | paused = not model.paused }
           , Cmd.none
           )
        Reset ->
           ({ model | elapsed = 0, deadLine = 1500, paused = False }
            , Cmd.none
           )

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
     if model.paused then Sub.none else Time.every 1000 Tick

-- View

view : Model -> Html Msg
view model =
    let
        minute  = String.fromInt ((model.deadLine - model.elapsed) // 60)
        seconds = String.fromInt (modBy 60 (model.deadLine - model.elapsed))
    in
        div []
        [ h2 [] [ text "Pomodoro Clock" ]
        , h4 [] [ text (minute ++ ":" ++ seconds) ]
        , button [ onClick ToggleStatus ] [ text (if model.paused then "Start" else "Pause") ]
        , button [ onClick Reset        ] [ text "Reset" ]
        ]
        
