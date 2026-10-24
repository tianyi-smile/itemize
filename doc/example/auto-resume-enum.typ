#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(auto-resuming: auto)
+ Item one
+ Item two
  + Sub item one
Paragraph
#el.auto-resume-enum(auto-resuming: true)[
  + New list item one
    + Sub item
    + Sub item
  + New list item two
    + Sub item (resume) // resume
  Paragraph
  + New list item (resume) // resume
]
+ New list item // not resume
