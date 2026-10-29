#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  label-baseline: ("horizon-item",auto),
  fill: (white, auto),
  weight: ("bold", auto),
  size: (1.2em, auto),
  label-format: (
    width-style: ((stretched: true, amount: 2em), auto),
    height-style: ((stretched: true, amount: 2em), auto),
    fill: (green, auto),
    radius: (2em, auto),
    align: (center + horizon, auto),
  ),
  body-format: (
    inner: (
      stroke: ((left: 3pt + green, rest: .5pt + green), auto),
      inset: ((left: 0.5em, y: 1em), auto),
    ),
  ),
)
#set enum(numbering: "1")
+ #lorem(5)
+ #lorem(15)
+ #lorem(5)
