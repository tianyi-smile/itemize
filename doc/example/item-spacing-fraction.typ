#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(item-spacing: 1fr)
#lorem(10)
#block(stroke: red, height: 3cm, width: 100%)[
  + Answer one
  + Answer two
  + Answer three
]
#lorem(10)
