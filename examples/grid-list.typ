#import "../lib.typ" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)

#let grid-list = el.default-list.with(
  body-indent: (0pt, auto),
  enum-spacing: (auto, 15pt),
  body-format: (
    whole: (
      stroke: (1pt, auto),
      radius: (10pt, auto),
      fill: (rgb("#eee5e5"), auto),
      inset: ((bottom: 5pt), auto),
    ),
    outer: (
      stroke: it => {
        if it.level == 1 {
          if it.n >= 2 {
            (top: 1pt + gray)
          }
        } else {
          auto
        }
      },
      inset: ((bottom: 15pt, top: 15pt, rest: 10pt), auto),
    ),
    style: (
      size: (15pt, 12pt),
    ),
  ),

  label-format: ([], auto),
)

#grid-list[
  #set par(justify: true)
  - #lorem(5)
    - #lorem(15)
    - #lorem(10)
  - #lorem(10)
    - #lorem(10)
  - #lorem(5)
    - #lorem(10)
]
