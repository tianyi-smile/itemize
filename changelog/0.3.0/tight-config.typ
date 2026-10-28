#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#let first-level-tight-mode = (
  tight: (auto, 0.65em),
  par-tight: (auto, auto),
  not-tight: (1.5em, 1.5em),
  par-not-tight: (2em, 2em),
)
#show: el.default-enum-list.with(
  tight-mode: (first-level-tight-mode, auto),
  body-format: (whole: (stroke: red)),
)
#show: el.config.auto-detect-tight

*config: tight-mode*

*Tight*: #lorem(2) *with parbreak*

+ #lorem(2) *without parbreak*
+ #lorem(2)
End paragraph

#lorem(2) *without parbreak*
+ #lorem(2) *without parbreak*
+ #lorem(2)
End paragraph
#divider()
*Not Tight*: #lorem(2) *with parbreak*

+ #lorem(2) *with parbreak*

+ #lorem(2)
End paragraph

#lorem(2) *without parbreak*
+ #lorem(2) *with parbreak*

+ #lorem(2)
End paragraph
