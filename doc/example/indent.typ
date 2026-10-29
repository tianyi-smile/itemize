#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let test = [
  + #lorem(2)
  + #lorem(2)
]
#table(columns: (1fr, 1fr), table.header([v0.3.0], [v0.2.0]))[
  #show: el.default-enum-list.with(indent: 1em, body-format: (whole: (stroke: red)))
  #test
][
  #import  "@preview/itemize:0.2.0" as el2
  #show: el2.default-enum-list.with(indent: 1em, body-format: (whole: (stroke: red)))
  #test
]
