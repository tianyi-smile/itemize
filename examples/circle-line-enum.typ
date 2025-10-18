#import "../lib.typ" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#let circle-line-enum = el.default-enum-list.with(
  size: (1.5em, auto),
  fill: (red, auto),
  body-indent: .5em,
  label-align: (center + horizon, auto),
  label-format: (circle.with(stroke: 1pt + blue, fill: white, width: 1.5em), auto),
  body-format: (
    inner: (
      stroke: ((left: 2pt + blue), auto),
      outset: (((left: 1.5em + 1pt, top: 0em), (left: 1.5em + 1pt, top: 1.3em)), auto),
    ),
  ),
)

#set enum(numbering: "1.1")

#circle-line-enum[
  + #lorem(5) 
    
    #lorem(5)
    - #lorem(15)
  + #lorem(15)
    + #lorem(10)
  + #lorem(15)
  + + #lorem(5)
    + #lorem(5)
  + #lorem(15)
]