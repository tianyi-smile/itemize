#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  tight-item-mode: ((tight: auto, not-tight: 2em), auto),
  body-format: (whole: (stroke: red)),
)
*Tight*:
+ #lorem(2)
+ #lorem(2)
*Not-tight*:
+ #lorem(2)

+ #lorem(2)
