#import "../lib.typ" as el
#set page(height: auto, margin: 15pt, width: 10cm)
#set align(left)
#set par(justify: true)
#show: el.default-enum-list.with(
  indent: 1em,
  label-align: right,
  label-width: 3em,
  label-format: (stroke: red),
  body-indent: 1em,
  hanging-indent: 2em,
  line-indent: 4em,
  body-margin: (right: 1em),
  whole-spacing: 2.5em,
  item-spacing: 2em,
  body-format: (
    whole: (stroke: blue, inset: 5pt),
    inner: (stroke: green, inset: 2pt),
  ),
)
Preceding Text. #lorem(10)
1. Item 1: Paragraph 1. #lorem(10)

  Paragraph 2. #lorem(10)

100. Item 2. #lorem(10)
Following Text. #lorem(10)
