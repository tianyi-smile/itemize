#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show: el.inline-enum-list
#set par(justify: true)
#set block(stroke: red) // debug
#lorem(15)
$ a^2 + b^2 = c^2 $
+ #lorem(15)
  $ a^2 + b^2 = c^2 $
  + #lorem(15)
  #block(fill: gray)[
    *Block: *
    #lorem(15)
  ]
  - #lorem(15)
+ - #lorem(15)
