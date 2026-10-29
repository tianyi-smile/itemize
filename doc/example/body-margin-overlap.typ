#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.paragraph-enum-list.with(
  body-format: (
    whole: (stroke: red, inset: 2pt),
    inner: (stroke: blue, inset: 2pt),
  ),
  body-margin: (0pt, auto)
)
+ #el.item(body-format: (inner: (fill: gray.lighten(70%)))) #lorem(15)

  #lorem(15)

  #block(stroke: 1pt, inset: 2pt)[
    #lorem(15)
  ]
+ #lorem(2)
