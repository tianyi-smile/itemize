#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Circle-numbered list with connector line
  #set par(justify: true)
  #let circle-line-enum = el.default-enum-list.with(
    size: (1.4em, auto),
    fill: (white, auto),
    item-spacing: (0pt, auto),
    body-indent: .5em,
    label-baseline: ("bottom", auto),
    label-format: (
      width-style: ((stretched: true, amount: 1.2em), auto),
      height-style: ((stretched: true, amount: 1.2em), auto),
      stroke: (blue, auto),
      align: (center + horizon, auto),
      radius: (50%, auto),
      fill: (blue, auto),
      inset: (.2em, auto),
    ),
    body-format: (
      whole: (
        stroke: ((left: 2pt + blue), auto),
        outset: ((left: -.9em + 1pt), auto),
      ),
      inner: (
        stroke: ((bottom: rgb("a5abd9") + .5pt), auto),
        inset: ((bottom: 0.65em), auto),
      ),
    ),
  )
  #circle-line-enum[
    #set enum(numbering: "1.a")
    + #lorem(2)

      #lorem(5)
      - #lorem(5)
    + #lorem(12)
    + - #lorem(5)
      - #lorem(5)
  ]
]
