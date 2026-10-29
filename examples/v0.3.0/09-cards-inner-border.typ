#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Numbered cards with inner border
  #show: el.default-enum-list.with(
    label-baseline: ("horizon-item", auto),
    fill: (white, auto),
    weight: ("bold", auto),
    size: (1.2em, auto),
    label-format: (
      width-style: ((stretched: true, amount: 2em), auto),
      height-style: ((stretched: true, amount: 2em), auto),
      fill: (rgb("#057510"), auto),
      radius: (50%, auto),
      align: (center + horizon, auto),
    ),
    body-format: (
      inner: (
        stroke: ((left: 3pt + rgb("#057510"), rest: .5pt + rgb("#057510")), auto),
        inset: ((left: 0.5em, y: 1em), auto),
      ),
    ),
  )
  #set enum(numbering: "1")
  + #lorem(5)
  + #lorem(15)
  + #lorem(5)
]
