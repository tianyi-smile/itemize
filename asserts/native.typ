#set page(height: auto, margin: 15pt, width: 12cm)
#import "../lib.typ" as el
#let test = [
  + + $vec(1, 1, 1)$ #lorem(2)
  #set list(marker: circle(width: 2em))
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
