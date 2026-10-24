#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(auto-resuming: auto)
#let emph-enum = el.item(body-format: (whole: (stroke: red, inset: 1pt)))
+ Item one
+ Item two
  + Sub item one
Paragraph
#el.resume[
  + #emph-enum New list item (resume) // resume
    + Sub item // not resume
  + New list item
]
+ New list item one // not resume
