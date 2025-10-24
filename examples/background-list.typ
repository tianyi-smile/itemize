#import "@preview/itemize:0.2.0" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#let background-list = el.default-list.with(
  label-format: ([], auto),
  body-format: (
    inner: (
      fill: (blue, auto),
      inset: (15pt, auto),
    ),
    style: (
      size: (25pt, auto),
      fill: white,
    ),
  ),
  is-full-width: false,
  enum-margin: (30%, 0em),
  item-spacing: (15pt, auto),
)

#background-list[
  #set par(justify: true)
  - Typst
  - Latex
  - MS-Word
  - WPS
]
