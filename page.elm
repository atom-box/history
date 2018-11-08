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
        [ """
             Article the first...  there shall be one Representative for every thirty thousand,
          """
        , """
             Article the second... No law, varying the compensation for the services of the Senators and Representatives, shall take effect, until an election of Representatives shall have intervened.
        """
        , """
             Article the third... Congress shall make no law prohibiting the free exercise thereof.
        """
        , """
             Article the fourth... the right of the people to keep and bear Arms, shall not be infringed.
        """
        , """
             Article the fifth... No Soldier shall be quartered in any house.
        """
        , """
        Article the sixth... no Warrants shall issue, but  particularly describing the place to be searched, and the persons or things to be seized.
        """
        , """
        Article the seventh... No private property be taken for public use, without just compensation.
        """
        , """
        Article the eighth...a public trial in the district wherein the crime shall have been committed, confronted with the witnesses against him;  and the Assistance of Counsel
        """
        , """
        Article the ninth... In suits at common law, where the value in controversy shall exceed twenty dollars, the right of trial by jury shall be preserved, and no fact tried by a jury, shall be otherwise re-examined in any Court of the United States, than according to the rules of the common law.
        """
        , """
        Article the tenth... Excessive bail shall not be required, nor excessive fines imposed, nor cruel and unusual punishments inflicted.
        """
        , """
        Article the eleventh... The enumeration in the Constitution, of certain rights, shall not be construed to deny or disparage others retained by the people.
        """
        , """
        Article the twelfth... The powers not delegated to the United States are reserved to the States respectively, or to the people.
          """
        ]
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
                | entries = model.filter :: model.entries
                , results = model.filter :: model.results
            }



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
