#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
/// for debug
#let v-line = context {
  let height = if page.height == auto {
    12cm // debug
  } else {
    page.height
  }
  box(outset: (top: height, bottom: height), stroke: 1pt + yellow)
}
#show: el.default-enum-list.with(auto-label-width: auto)
+ #lorem(2)
Paragraph
#el.auto-label-item[
  + #lorem(2)
    + #lorem(2)
    + #lorem(2)
  Paragraph
  10. #v-line#lorem(2)
    100. #v-line#lorem(2)
]
Paragraph
+ #lorem(2)
