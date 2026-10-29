#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#set par(justify: true)
#el.default-enum-list(
  label-width: (amount: 2em, style: "constant"),
  label-format: (stroke: red),
)[
  1. #lorem(10)
  11. #lorem(10)

      #lorem(15)
  1111. #lorem(10)
  111111. #lorem(10)
]
