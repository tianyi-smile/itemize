
#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#set enum(numbering: "1.a)")
#table(
  columns: (1fr, 1fr),
  table.header([*itemize0.3.0*], [*itemize0.2.0*]),
  [
    #show: el.default-enum-list.with(
      body-format: (
        inner: (strong, emph, auto),
        whole: (auto, highlight, auto),
      ),
    )
    + #lorem(2)
      + #lorem(2)
    + #lorem(2)
  ],
  [
    #import "@preview/itemize:0.2.0" as el2
    #show: el2.default-enum-list.with(item-format: (
      inner: (strong, emph, auto),
      whole: (auto, highlight, auto),
    ))
    + #lorem(2)
      + #lorem(2)
    + #lorem(2)
  ],
)
