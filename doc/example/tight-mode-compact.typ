#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  tight-mode: ("compact-tight", auto), 
  body-format: (whole: (stroke: (red, blue, auto)))
)
Paragraph
+ #lorem(2)

  Paragraph // below has a `parbreak()`

  + #lorem(2)
  + #lorem(2)
  End Paragraph
+ #lorem(2)
End Paragraph
