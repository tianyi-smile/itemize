#import "@preview/itemize:0.2.0" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#let orange-enum = el.default-enum.with(
  fill: orange,
  weight: "bold",
  size: (20pt, auto),
  body-format: (
    whole: (
      radius: (10pt, auto),
      fill: (orange.lighten(50%), auto),
      inset: (10pt, auto),
    ),
    inner: (
      radius: (10pt, auto),
      fill: (orange.lighten(70%), auto),
      inset: ((bottom: 10pt, rest: 5pt), auto),
    ),
  ),
)

#orange-enum[
  + #lorem(20)
    + #lorem(10)
    + #lorem(10)
  + #lorem(10)
  + #lorem(10)
]