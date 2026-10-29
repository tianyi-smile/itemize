#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  size: 1.5em,
  fill: red,
  label-format: (
    stroke: red,
    fill: (gray, yellow, auto)
))
+ #lorem(2)
  + #lorem(2)
    + #lorem(2)
    + #lorem(2)
+ #lorem(2)
