#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  fill: it => {
    if it.elem-tag == "important" { red } else {
      if it.tag == "important" { blue } else { auto }
    }
  }
)
+ #lorem(2)
  + #el.item(elem-tag: "important") #lorem(2)
  + #lorem(2)
  Paragraph
  + #lorem(2)
+ #el.item(tag: "important") #lorem(2)
+ #lorem(2)
