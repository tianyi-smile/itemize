#import "@preview/itemize:0.2.0" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#let el-word = el.default-enum-list.with(
  label-width: (2em, 1em),
  label-align: (right, left),
)

#[
  #show: el-word
  + #lorem(15)
    + #lorem(5)
    + #lorem(5)
    - #lorem(5)
    1000. #lorem(15)
  + #lorem(5)
  100. #lorem(5)
  1000. #lorem(15)
  100000. #lorem(20)
]