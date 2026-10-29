#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  fill: it => {
    if it.elem-tag == "resume" { red } else { auto }
  },
  auto-resuming: it => {
  if it.elem-tag == "resume" { true } else { false }
})
+ #lorem(2)
  + #lorem(2)
  + #lorem(2)
Paragraph
+ #lorem(2)
  + #el.item(elem-tag: "resume") #lorem(2)
+ #lorem(2)
  + #el.item(elem-tag: "resume") #lorem(2)
  + #lorem(2)
