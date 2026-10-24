#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  label-format: it => {
    if it.tag == "strong" {
      set text(fill: red, weight: "bold")
      it.body
    } else {
      it.body
    }
  })
+ #el.item(tag: "strong") #lorem(2)
+ #lorem(2)
  + #lorem(2)
  + #el.item(tag: "strong") #lorem(2)
