#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  fill: red,
  label-format: (
    stroke: red,
    inset: 2pt,
    radius: 1em,
))
+ #lorem(2)
  + #lorem(2)
    + #lorem(2)
    + #lorem(2)
+ #lorem(2)
