#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let test = block(stroke: red, inset: 5pt)[
  + Level1 One
  + Level1 Two
    + Level2-1
    + Level2-2
      + Level3
        + Level4
    + Level2-3
    + Level2-4
]
#[
  #show: el.default-enum-list.with(
    fill: (red, green, blue), // level 1: red, level 2: green, subsequent levels: blue
  )
  #test
]
#[
  #show: el.default-enum-list.with(
    fill: (red, green, blue, el.LOOP), // level 1: red, level 2: green, level 3: blue, level 4: red (cyclically used)
  )
  #test
]
#[
  #show: el.default-enum-list.with(
    fill: (red, (purple, green, el.LOOP), blue), // level 1: red, level 2 (index 1: purple, index 2: green, index 3: purple, index 4: green, cyclically used), subsequent levels: blue
  )
  #test
]
