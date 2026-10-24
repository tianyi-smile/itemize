#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-list.with(
  label-format: (
    inset: ((left: 0.5em), auto),
    width-style: ((stretched: true), auto),
    format: (strong, auto)
  ),
  body-indent: (2em, auto),
  item-spacing: (0pt, auto),
  body-format: (
    whole: (
      fill: (gray, auto)
    ),
    inner: (
      fill: (white, auto), 
      stroke: (gray.lighten(50%), auto),
      inset: (5pt, auto),
    )
  ),
)
#set par(justify: true)
- #el.item([Item one]) #lorem(10)
- #el.item([Item two]) #lorem(2)
