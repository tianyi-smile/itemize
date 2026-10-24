#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  body-margin: ((right: 2em), auto),
  body-format: (whole: (stroke: red, inset: 2pt), outer: (stroke: blue))
)
+ #lorem(10)
+ #lorem(3)
