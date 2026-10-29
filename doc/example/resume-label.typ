#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(auto-resuming: auto)
+ Item one
+ Item two
  + Sub item one
  + Sub item Two
  + Sub item Three (label) #el.resume-label(<resume:sub>) // The enum you want to resume
Paragraph
#el.resume-list(<resume:sub>)
+ New Item (resume) // resume
