#import "@preview/itemize:0.3.0" as el

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Nested filled cards
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
        inset: (10pt, auto),
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
]
