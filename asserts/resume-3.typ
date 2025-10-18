#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#let resume-enum(doc) = el.default-enum-list(auto-resuming: auto)[
  #el.auto-resume-enum(auto-resuming: true, doc)
]
#resume-enum[
  + #lorem(5)
    + #lorem(5)
    + #lorem(5)
      + #lorem(5)
    - #lorem(5)
    + #lorem(5)
      + #lorem(5)
  #lorem(5)
  + #lorem(5)
]
