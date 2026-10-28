#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
  #show: el.default-enum-list
  #let marker = level => {
    if level == 0 { // stand for level 1!!!
      ([#sym.suit.club.filled], [#sym.suit.spade.filled], [#sym.suit.heart.filled], el.LOOP)
    } else if level == 1 { // stand for level 2!!! The first item's number starts from 0
      n => rotate(24deg * n, box(rect(stroke: 1pt + blue, height: 1em, width: 1em)))
    } else { // others
      [#sym.ballot.check.heavy]
    }
  }
  #set list(marker: marker)
  - #lorem(5)
  - #lorem(5)
    - #lorem(5)
    - #lorem(5)
      - #lorem(5)
      - #lorem(5)
    - #lorem(5)
    - #lorem(5)
    - #lorem(5)
  - #lorem(5)
    - #lorem(5)
  - #lorem(5)