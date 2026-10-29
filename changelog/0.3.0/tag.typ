#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show: el.default-enum-list.with(
  body-format: (
    inner: (
      format: it => {
        if it.tag == "emph" {
          set text(fill: red)
          show: emph
          it.body
        } else {
          it.body
        }
      },
    ),
    whole: (
      stroke: it => if it.elem-tag == "stroke:red" { red } else { auto },
    ),
  ),
  label-format: it => {
    if type(it.tag) == array {
      let fmt-strong = body => {
        if "strong" in it.tag {
          set text(fill: orange)
          show: strong
          body
        } else {
          body
        }
      }
      let fmt-highlight = body => {
        if "highlight" in it.tag {
          show: highlight
          it.body
        } else {
          body
        }
      }
      fmt-strong(fmt-highlight(it.body))
    } else {
      it.body
    }
  },
)
+ #lorem(2)
+ #el.item(tag: "emph") #lorem(2)
+ #lorem(2)
  + #el.item(tag: ("strong",), elem-tag: "stroke:red") #lorem(2)
  + #el.item(tag: ("strong", "highlight")) #lorem(2)
  + #lorem(2)
