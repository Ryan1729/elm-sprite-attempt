module Main (..) where

import Window
import Graphics.Element as E exposing (Element)
import Text
import StaticSprite exposing (Sprite)
import Html
import Array
import Html.Attributes as A


main : Signal Element
main =
  Signal.map
    view
    Window.dimensions


spritesInRow : Int
spritesInRow =
  6


view : ( Int, Int ) -> Element
view ( width, height ) =
  let
    sectionWidth =
      width // 2

    sectionHeight =
      height // 3

    sectionSize =
      min (sectionWidth // spritesInRow) sectionHeight

    ratioPreservingWidth =
      (sectionSize * spritesInRow)

    ratioPreservingHeight =
      sectionSize
  in
    E.container
      width
      height
      E.middle
      <| E.flow
          E.down
          [ spriteCollection ratioPreservingWidth ratioPreservingHeight
          , labels ratioPreservingWidth ratioPreservingHeight
          , E.image ratioPreservingWidth ratioPreservingHeight "spriteTestExpectedResult.png"
          ]


labels : Int -> Int -> Element
labels width height =
  E.container width height E.middle
    <| E.flow
        E.down
        [ E.leftAligned <| Text.fromString "sprite attempt &uarr;"
        , E.spacer width (height // 3)
        , E.leftAligned <| Text.fromString "desired result (with premade image) &darr;"
        ]


spriteCollection : Int -> Int -> Element
spriteCollection width height =
  let
    spriteWidth =
      width // spritesInRow

    spriteHeight =
      height

    red =
      makeSprite spriteWidth spriteHeight 0

    green =
      makeSprite spriteWidth spriteHeight 1

    blue =
      makeSprite spriteWidth spriteHeight 2
  in
    E.flow
      E.right
      [ blue, green, green, red, red, blue ]


spriteSize : Int
spriteSize =
  64


makeSprite : Int -> Int -> Int -> Element
makeSprite width height index =
  spriteToElement (min width height) (initSprite index)


initSprite : Int -> Sprite {}
initSprite frame =
  { sheet = "spriteTest.png"
  , rows = 1
  , columns = 3
  , size = ( 192, 64 )
  , frame = ( frame, 0 )
  }


spriteToElement : Int -> Sprite {} -> Element
spriteToElement cellSize s =
  Html.node
    "sprite"
    [ A.style (StaticSprite.sprite s) ]
    []
    --these int to toElement parameters don't seem to do anything.
    |>
      Html.toElement cellSize cellSize
    |>
      E.size cellSize cellSize
