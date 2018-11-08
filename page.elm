module Page exposing (main)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



{-
   The MODEL and UPDATE were
    derived/forked from
    https://css-tricks.com/introduction-elm-architecture-build-first-application/
-}


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL -------------------------


type alias Model =
    { entries : List String
    , results : List String
    , filter : String
    }



{-
      todo
   History browser
   * Pipe parser the bash_history as a comment in code file.  Ports + flags will be the way to go ultimately when bringing in a local file. But for this weekend, do bash_history -> unix pipeline to
        warm up the pipe idea.
   * write page.elm so it just serves a short list of things, no headline.  compiles to page.html <students add in the things themselves>
   * add h1, h3 headlines (oops, no exposed) with purpose and your name
   * cat .bash_history to history_november.txt
   * write elm function to bring it in to the list
   * graft on to html frame with the css
   * stitch on the searcher

-}


init : Model
init =
    Model
        bashList
        []
        ""



-- UPDATE -----------------------------


type Msg
    = All
    | Filter String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Filter filter ->
            { model
                | results = List.filter (String.contains filter) model.entries
                , filter = filter
            }

        All ->
            { model
                | results = model.entries
            }



{-
           All ->
               { model
                   | entries = model.filter :: model.entries
                   , results = model.filter :: model.results
               }
   Insights:
       1) model.entries is immutable remember.
-}
-- VIEW -------------------------------


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Searchable Bill of Rights:" ]
        , p [ class "directions" ] [ text direction1 ]
        , input [ placeholder "enter a search term", onInput Filter ] []
        , button [ onClick All ] [ text "Show All" ]
        , p [ class "directions" ] [ text blankLine ]
        , p [ class "directions" ] [ text direction2 ]
        , ul [] (List.map viewEntry model.results)
        ]


viewEntry : String -> Html Msg
viewEntry entry =
    li [] [ text entry ]


direction1 =
    "Try typing 'we' into the box."


blankLine =
    ""


direction2 =
    "Search results:"



{-
   The list below got populated by
   cat  ~/.bash_history | sed 's/\(^.*$\)/"\1" ,/' >> page.elm
   followed by removing the last comma and
   adding a closing square bracket.
-}


bashList =
    [ "git push janesville master"
    , "pwd"
    , "cd .."
    , "pwd"
    , "mkdir duck4"
    , "cd duck4/"
    , "git init"
    , "touch .gitignore"
    , "touch README.md"
    , "nano README.md "
    ]
