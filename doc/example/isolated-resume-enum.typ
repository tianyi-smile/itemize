#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let emph-enum(color) = el.item(body-format: (whole: (stroke: color, inset: 1pt)))
#table(
  columns: (1fr, 1fr),
  table.header[Case 1][Case 2],
  [
    #show: el.default-enum-list.with(auto-resuming: auto)
    + enumA #lorem(2)
      + enumB #lorem(1)
    Paragraph
    + #emph-enum(blue) enumC #lorem(1)
    + #lorem(2)
      + enumD #lorem(1)
      + #lorem(2)
    Paragraph
    #el.resume() // -> 3
    + *resume enumC*
      #el.resume() // -> 3
      + *resume enumD*
  ],
  [
    #show: el.default-enum-list.with(auto-resuming: auto)
    + enumA #lorem(2)
      + enumB #lorem(1)
    Paragraph
    #el.isolated-resume-enum()[
      // isolated enum
      + #emph-enum(red) enumC #lorem(1)
      + #lorem(2)
        + enumD #lorem(1)
        + #lorem(2)
    ]
    Paragraph
    #el.resume() // -> 2
    + *resume enumA*
      #el.resume() // -> 2
      + *resume enumB*
  ],
)
