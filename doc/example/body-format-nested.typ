#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#set enum(numbering: "(a)(i)(1)")
#show: el.default-enum-list.with(
  body-format: (
    outer: (
      fill: (orange.lighten(80%), auto),
      inset: (5pt, 5pt, auto)
    ),
    whole: (
      stroke: (auto, (left: 4pt + orange, rest: 1pt + orange), auto),
      inset: (auto, (bottom: 1pt, left: 2pt), auto),
      outset: (auto, (left: -2pt), auto),
      format: it => {
        if it.level == 2 {
          set text(fill: orange)
          place(right+bottom)[#sym.suit.club.filled]
          it.body
        } else {
          it.body
        }
      }
    )
  ),
)
+ #lorem(15)
  + #lorem(15)
  + + #lorem(15)
+ #lorem(15)
  + #lorem(15)
  + #lorem(15)
