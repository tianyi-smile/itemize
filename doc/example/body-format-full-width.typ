#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#[
  #show: el.default-enum-list.with(body-format: (whole: (width: 100%, stroke: red)))
  *full width*:
  #box([
    + #lorem(5)
    + #lorem(2)
  ])
]
#[
  #show: el.default-enum-list.with(body-format: (whole: (stroke: red)))
  *auto width*:
  #box([
    + #lorem(5)
    + #lorem(2)
  ])
]
