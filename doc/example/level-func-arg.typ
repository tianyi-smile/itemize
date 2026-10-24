#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  fill: it => {
    if it.level == 1 {
      red // level 1: red
    } else {
      (purple, blue, el.LOOP) // subseqence levels (index 1: purple, index 2: green, index 3: purple, index 4: green, cyclically used)
    }
  },
)
+ Level1 One
+ Level1 Two
  + Level2-1
  + Level2-2
    + Level3-1
    + Level3-2
    + Level3-3
  + Level2-3
  + Level2-4
