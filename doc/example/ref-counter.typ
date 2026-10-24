#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let my-counter = counter("my")
#show: el.default-enum-list.with(
  supplement: it => {
    [#std.numbering("1.", ..(my-counter).at(it.target))#it.body]
  },
)
#set enum(numbering: "i.a.", full: true)
Paragraph
#my-counter.step()
+ #lorem(2)
  + #lorem(5) 
  + #lorem(4) <item:testa>
+ #lorem(3)

Paragraph
#my-counter.step()
+ #lorem(2)
+ #lorem(3)
  + #lorem(5) <item:testb>

Test: @item:testa

Test: @item:testb
