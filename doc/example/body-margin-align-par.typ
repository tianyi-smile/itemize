#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let indent = 2em
#set par(first-line-indent: (amount: indent, all: true))
#show: el.default-enum-list.with(
  body-margin: (0pt, auto),
  indent: (indent, auto),
  label-indent: it => {
    if it.level == 1 {
      -it.label-width.current - it.e.body-indent
    } else {
      auto
    }
  },
)
#lorem(15)
+ #lorem(15)
  + #lorem(15)
+ #lorem(15)
