#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#let v-line = context {
  let height = if page.height == auto {
    12cm // debug
  } else {
    page.height
  }
  box(outset: (top: height, bottom: height), stroke: 1pt + yellow)
}
#let indent = 2em
#set par(first-line-indent: (amount: indent, all: true))

= Style One
#lorem(15)
#[
  #show: el.default-enum-list.with(
    body-margin: ((left: 0em), auto),
    indent: (indent, auto),
    label-indent: it => {
      if it.level == 1 {
        -it.label-width.current - it.e.body-indent
      } else {
        auto
      }
    },
  )
  + #v-line#lorem(15)
    + #lorem(15)
  + #lorem(15)

    #lorem(15)
]
= Style Two
#lorem(15)
#[
  #show: el.default-enum-list.with(
    body-margin: ((left: 0em), auto),
    indent: (0pt, 2em, auto),
    label-indent: it => {
      if it.level == 1 {
        2em - (it.label-width.current + it.e.body-indent)
      } else {
        auto
      }
    },
  )
  + #v-line#lorem(15)

    #lorem(15)
    + #lorem(15)
  + #lorem(15)

    #lorem(15)
]
