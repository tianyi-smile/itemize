#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show: el.default-enum-list.with(
  line-indent: 2em,
  hanging-type: ("classic", "paragraph", auto),
)
+ #lorem(15)
  + #lorem(15)

    #lorem(15)
  + #lorem(15)
+ #lorem(15)
