#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let test = [
  + #lorem(15)
    + #lorem(2)
  100. #lorem(2)
]
#[
  #show: el.default-enum-list.with(label-inset: -.5em, label-width: 2em)
  #test
]
#[
  #show: el.default-enum-list.with(label-width: 2em)
  #test
]
