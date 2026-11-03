#import "@preview/itemize:0.3.0" as el

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Cards with vertical accent line
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
]
