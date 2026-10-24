#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  description-config: (
    style: it => {
      if it.elem-tag == "stacked-important" { "stacked" } else {"horizontal"}
    },
    term-format: (strong,),
    format: it => {
      if it.elem-tag == "stacked-important" {
        show: highlight
        it.body
      } else {
        it.body
      }
    }
  ),
)
- / #lorem(2): #lorem(10)
- / #lorem(1): #lorem(10)
Paragraph
- #el.item(elem-tag: "stacked-important")
  / #lorem(2): #lorem(10)
- / #lorem(3): #lorem(10)
