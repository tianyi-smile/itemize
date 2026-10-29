#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  tight-item-mode: "always-tight",
  body-format: (whole: (stroke: red)),
)
*Tight*:
+ #lorem(2)
+ #lorem(2)
*Not-tight*:
+ #lorem(2)

+ #lorem(2)
