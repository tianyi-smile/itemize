#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  fill: (white, auto),
  weight: ("bold", auto),
  size: (1.2em, auto),
  label-format: (
    width-style: ((stretched: true, amount: 2em), auto),
    height-style: ((stretched: true, amount: 2em), auto),
    fill: (blue, auto),
    radius: (2em, auto),
    align: (center + horizon, auto),
  ),
  body-format: (
    outer: (
      stroke: ((left: 3pt + blue, rest: .5pt + blue), auto),
      inset: ((left: 2pt), auto),
      outset: ((left: -2em - 0.5em), auto),
    ),
  ),
)
#set enum(numbering: "1")
+ #lorem(5)
+ #lorem(25)
+ #lorem(5)
