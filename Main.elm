module Main (..) where

import Window
import Graphics.Element as E exposing (Element)
import Text


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
  E.croppedImage
    ( index * spriteSize, spriteSize // 2 )
    spriteSize
    spriteSize
    "spriteTest.png"
    |> E.size
        width
        height


labels : Int -> Int -> Element
labels width height =
  E.container width height E.middle
    <| E.flow
        E.down
        [ E.leftAligned <| Text.fromString "sprite attempt &uarr;"
        , E.spacer width (height // 3)
        , E.leftAligned <| Text.fromString "desired result (with premade image) &darr;"
        ]
