#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let stacked = el.item(
  description-config: (
    style: "horizontal",
    term-format: (strong,),
  ),
  for-elem: true
)
#show: el.default-enum-list
- #stacked
  / #lorem(2): #lorem(10)
- / #lorem(1): #lorem(10)
