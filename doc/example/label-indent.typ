#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let test = [
  + #lorem(10)
    + #lorem(5)
  + #lorem(10)
]
#table(columns: (1fr, 1fr), table.header([default], [paragraph]))[
  #show: el.default-enum-list.with(label-indent: 1em, body-format: (whole: (stroke: red)))
  #test
][
  #show: el.paragraph-enum-list.with(label-indent: 1em, body-format: (whole: (stroke: red)))
  #test
]
