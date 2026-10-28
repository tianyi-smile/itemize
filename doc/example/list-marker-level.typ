#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let test-list = [
  - #lorem(5)
    - #lorem(5)
    - #lorem(5)
  - #lorem(5)
]
#[
  #show: el.default-enum-list.with(label-format: it => [#it.level - #it.n])
  #test-list
]
#[
  #set list(marker: level => n => [#level - #n])
  #show: el.default-enum-list.with(auto-base-level: true)
  #test-list
]
