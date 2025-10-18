#import "../lib.typ" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#[
  #show: el.config.checklist.with(
    baseline: "center",
    enable-format: true,
    radius: 1em,
    extras: true,
    format-map: ("!": text.with(fill: blue, weight: "bold")),
  )
  #show: el.default-enum-list.with(fill: (blue, auto))
  - [ ] #lorem(5)
  - [x] #lorem(5)
  - [-] #lorem(5)
  - [/] #lorem(5)
  - [!] #lorem(5)
  - [?] #lorem(5)
  - [>] #lorem(5)
  - [p] #lorem(5)
  - [1] #lorem(5)
  - [Y] #lorem(5)
  - [a] #lorem(5)
]