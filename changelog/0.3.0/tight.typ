#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el
#let test = [
  + #lorem(2)
    + #lorem(2)
    + #lorem(2)
    #lorem(2)
  + #lorem(2)
    + #lorem(2)
    + #lorem(2)
  + #lorem(2)
  End paragraph
]
#[
  #show: el.default-enum-list.with(tight-mode: "never-tight", tight-item-mode: "never-tight")
  *tight-mode: "never-tight", tight-item-mode: "never-tight"*:
  #test
]

#[
  #show: el.default-enum-list.with(tight-mode: "never-tight", tight-item-mode: "always-tight")
  *tight-mode: "never-tight", tight-item-mode: "always-tight"*:
  #test
]

#[
  #show: el.default-enum-list.with(tight-mode: "always-tight", tight-item-mode: "always-tight")
  *tight-mode: "always-tight", tight-item-mode: "always-tight"*:
  #test
]

