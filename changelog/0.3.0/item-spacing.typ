#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: 10cm, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show: el.default-enum-list.with(item-spacing: (below: 1fr))
#lorem(10)
+ Answer one
+ Answer two
+ Answer three
#lorem(10)
