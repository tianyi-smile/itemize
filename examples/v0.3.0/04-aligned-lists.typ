#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#let v-line = context {
  let height = if page.height == auto {
    12cm // debug
  } else {
    page.height
  }
  box(outset: (top: height, bottom: height), stroke: 1pt + gray.lighten(50%))
}
#[
  = Aligned lists
  #set block(clip: true)
  #table(
    columns: (1fr,) * 2,
    [
      #let max = 3.2em
      #show: el.default-enum.with(
        body-margin: (0pt,),
        indent: (max, 0pt),
        body-indent: (1em,),
        label-width: max,
        label-indent: it => {
          -it.label-width.current
        },
        label-align: left,
        weight: "black",
      )
      #set enum(full: true)
      #lorem(5)
      + #v-line#lorem(2)
        + #lorem(2)
          + #lorem(2)
            + #lorem(2)
        + #lorem(2)
      + #lorem(2)
    ],
    [
      #let max = 3.2em
      #show: el.default-enum.with(
        body-margin: (0pt,),
        indent: (max, 0pt),
        body-indent: (1em,),
        label-width: max,
        label-indent: it => {
          -it.label-width.current
        },
        label-align: right,
        weight: "black",
      )
      #set enum(full: true)
      #lorem(5)
      + #v-line#lorem(2)
        + #lorem(2)
          + #lorem(2)
            + #lorem(2)
        + #lorem(2)
      + #lorem(2)
    ],

    [
      #let indent = 2em
      #set par(first-line-indent: (amount: indent, all: true))
      #show: el.default-enum-list.with(
        body-margin: (0pt, auto),
        indent: (0pt, indent, auto),
        label-indent: it => {
          if it.level == 1 {
            indent - it.label-width.current - it.e.body-indent
          } else {
            auto
          }
        },
      )
      #set enum(numbering: "(1.a)")
      #lorem(6)
      + #v-line#lorem(6)
        - #lorem(6)
        - #lorem(6)
      + #lorem(2)
      #lorem(6)
    ],
    [
      #let indent = 2em
      #set par(first-line-indent: (amount: indent, all: true))
      #show: el.default-enum-list.with(
        body-margin: (0pt, auto),
        indent: (indent, auto),
        label-indent: it => {
          if it.level == 1 {
            -it.label-width.current - it.e.body-indent
          } else {
            auto
          }
        },
      )
      #lorem(6)
      #set enum(numbering: "(I.a)")
      + #v-line#lorem(6)
        - #lorem(6)
        - #lorem(6)
      + #lorem(2)
      #lorem(6)
    ],
  )

]
