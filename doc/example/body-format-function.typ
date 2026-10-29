#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(body-format: it => {
  if it.e.tight {
    show: highlight
    set text(fill: red)
    it.body
  } else {
    it.body
  }
})
+ #lorem(2)
+ #lorem(2)
Paragraph
+ #lorem(2)

+ #lorem(2)
