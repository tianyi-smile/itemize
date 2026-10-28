#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el


#show: el.default-enum-list
+ #el.item(body-format: (outer: (stroke: red, inset: 5pt)), for-elem: true) #lorem(2)
+ #el.item(fill: red) #lorem(2)
  - #lorem(2)
  - #lorem(2)
+ #lorem(2)
