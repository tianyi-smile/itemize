#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Numbered cards with outer border
  #show: el.default-enum-list.with(
    fill: (white, auto),
    weight: ("bold", auto),
    size: (1.2em, auto),
    label-format: (
      width-style: ((stretched: true, amount: 2em), auto),
      height-style: ((stretched: true, amount: 2em), auto),
      fill: (green, auto),
      radius: (50%, auto),
      align: (center + horizon, auto),
    ),
    body-format: (
      outer: (
        stroke: ((left: 3pt + green, rest: .5pt + green), auto),
        inset: ((left: 0.5em, y: .5em), auto),
      ),
    ),
  )
  #set enum(numbering: "1")
  + #lorem(5)
  + #lorem(15)
  + #lorem(5)
]
