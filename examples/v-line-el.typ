#import "../lib.typ" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#let v-line-el = el.default-enum-list.with(
  body-format: (
    outer: (
      stroke: ((left: .2em + blue), auto),
      inset: ((left: .5em, y: 5pt), auto),
      fill: (blue.lighten(95%), auto),
    ),
  ),
)


#v-line-el[
  + #lorem(5)
  + #lorem(15)

    #lorem(5)
  + #lorem(5)
    - #lorem(15)
    + - #lorem(5)
]
