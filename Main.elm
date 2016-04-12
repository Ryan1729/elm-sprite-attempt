module Main (..) where

import Window
import Graphics.Element as E exposing (Element)


main : Signal Element
main =
  Signal.map
    view
    Window.dimensions


view : ( Int, Int ) -> Element
view ( width, height ) =
  let
    sectionWidth =
      width // 2

    sectionHeight =
      height // 3

    sectionSize =
      min (sectionWidth // 6) sectionHeight
  in
    E.container
      width
      height
      E.middle
      <| E.flow
          E.down
          [ spriteCollection (sectionSize * 6) sectionSize
          , E.spacer (sectionSize * 6) sectionSize
          , E.image (sectionSize * 6) sectionSize "spriteTestExpectedResult.png"
          ]


spriteCollection : Int -> Int -> Element
spriteCollection width height =
  let
    spriteWidth =
      width // 6

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


makeSprite width height index =
  E.croppedImage
    ( index * spriteSize, spriteSize // 2 )
    spriteSize
    spriteSize
    "spriteTest.png"
    |> E.size
        width
        height
