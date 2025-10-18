#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#set align(center)
#set par(justify: true)
#block(width: 80%, stroke: 1pt + red, inset: 5pt)[
  #set align(left)
  #show: el.default-enum-list.with(
    indent: 1em,
    label-align: right,
    label-width: 3em,
    body-indent: 1em,
    hanging-indent: 2em,
    line-indent: 4em,
    is-full-width: false,
    enum-margin: 4em,
    enum-spacing: 3em,
    item-spacing: 2.5em,
  )
  Preceding Text. #lorem(30)

  1. Item 1: Paragraph 1. #lorem(30)

    Paragraph 2. #lorem(30)

  100. Item 2. #lorem(30)

  Following Text. #lorem(30)
]
