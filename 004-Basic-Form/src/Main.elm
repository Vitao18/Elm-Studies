import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- Main

main =
    Browser.sandbox { init = init, update = update, view = view }

-- Model

type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    }

init : Model
init =
   Model "" "" "" ""


-- Update

type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }
        Password password ->
            { model | password = password }
        PasswordAgain passwordagain ->
            { model | passwordAgain = passwordagain }
        Age age ->
            { model | age = age }
            
-- View

view : Model -> Html Msg
view model =
    div []
      [ viewInput "text"     "Name"              model.name          Name
      , viewInput "password" "Password"          model.password      Password
      , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
      , viewInput "age"      "Age"               model.age           Age
      , viewValidation model
      ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []

checkPassword : String -> Bool
checkPassword password =
     String.any Char.isDigit password && String.any Char.isUpper password && String.any Char.isLower password
         
viewValidation : Model -> Html msg
viewValidation model =
    if not (String.all Char.isDigit model.age) then
        div [ style "color" "red"   ] [ text "Age needs to be a number" ]
    else if String.length model.password < 9 then
        div [ style "color" "red"   ] [ text "Password is too small" ]
    else if not (checkPassword model.password) then
        div [ style "color" "red"   ] [ text "Passwords need at least a digit, a uppercase and a lowercase" ]
    else if model.password == model.passwordAgain then
        div [ style "color" "green" ] [ text "Ok"]
    else
        div [ style "color" "red"   ] [ text "Passwords do not match!" ]
