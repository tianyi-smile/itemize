#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  tight-item-mode: ("never-tight", auto),
  description-config: (
    prefix: it => {
      if it.tag == "prefix-important" {
        box(height: 1em, width: .2em, fill: red, baseline: .2em)
        h(.3em, weak: true)
      }
    },
    suffix: it => {
      if it.tag == "prefix-important" {
        h(.3em, weak: true)
        box(height: 1em, width: .2em, fill: red, baseline: .2em)
      }
    },
    term-format: (strong,),
    // style: "hanging",
  ),
)
- #el.item(tag: "prefix-important")
  / Alpha: #lorem(10)
- / Beta: #lorem(10)
