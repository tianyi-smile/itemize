#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.paragraph-enum-list.with(
  body-format: (
    whole: (stroke: red, inset: 2pt),
    inner: (stroke: blue, inset: 2pt),
  ),
)
+ #lorem(15)

  #lorem(15)

  #block(stroke: 1pt, inset: 2pt, width: 100%)[
    #lorem(15)
  ]
+ #lorem(2)
