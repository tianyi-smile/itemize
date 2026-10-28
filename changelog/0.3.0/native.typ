#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "@local/itemize:0.3.0" as el
#let test = [
  + + $vec(1, 1, 1)$ #lorem(2)
  #set list(marker: _ => { circle(width: 2em) })
  - #lorem(2)
]
#table(
  columns: (1fr, 1fr),

  table.header([*Native*], [*Itemize*]),
  [#test],
  [
    #show: el.default-enum-list
    #test
  ],
)
