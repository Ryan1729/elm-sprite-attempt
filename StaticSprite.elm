module StaticSprite (..) where

--this is based on FreshEyeball/Sprite 1.0.0

import Array exposing (Array)


{-|
A sprite sheet
-}
type alias Sprite a =
  { a
    | sheet : String
    , rows : Int
    , columns : Int
    , size : ( Int, Int )
    , frame : Int
    , dope : Dope
  }


{-|
The ordered frame coordinates representing an animation
-}
type alias Dope =
  Array ( Int, Int )


{-|
Process a sprite into styles for application with
`elm-html`. Styles place the sprite sheet as a `background-image`
and animate by altering the `background-position`. `height`, `width`
are used for sizing, along with `display:block` for custom nodes.
-}
sprite : Sprite a -> List ( String, String )
sprite { sheet, rows, columns, size, dope, frame } =
  let
    px x =
      toString x ++ "px"

    ( sizeX, sizeY ) =
      size

    ( frameX, frameY ) =
      case Array.get frame dope of
        Nothing ->
          ( 0, 0 )

        Just x ->
          x

    height =
      sizeY // rows

    width =
      sizeX // columns

    backgroundImage =
      ( "background-image", "url(" ++ sheet ++ ")" )

    backgroundPosition =
      let
        posX =
          frameX * width * -1 |> px

        posY =
          frameY * height * -1 |> px
      in
        ( "background-position", posX ++ " " ++ posY )
  in
    backgroundImage
      :: ( "height", px height )
      :: ( "width", px width )
      :: ( "display", "block" )
      :: ( "background-repeat", "no-repeat" )
      :: backgroundPosition
      :: []
