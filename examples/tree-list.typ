#import "../lib.typ" as el

#import "@preview/catppuccin:1.0.1": get-flavor
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#let flavor = get-flavor("latte")
#let palette = flavor.colors

#let colors = (
  (
    "red",
    "yellow",
    "green",
    "blue",
    "mauve",
  ).map(c => flavor.colors.at(c).rgb)
    + (el.LOOP,)
)

#let tree-marker = (none, [$times.circle$], [$ast.circle$], [$star.filled$], [$times.div$])
#let tree-list = el.default-list.with(
  indent: ((0pt,),),
  fill: colors,
  item-spacing: .7em,
  enum-spacing: (auto, .7em),
  label-align: (center + horizon),
  label-baseline: .3em,
  body-indent: 0pt,
  label-format: it => {
    let marker-content = box(height: 1.2em, fill: white)[
      #set text(baseline: -.05em)
      #it.body #box(baseline: -.35em)[#line(length: 1em)]~]
    if it.level == 1 {
      none
    } else {
      marker-content
    }
  },
  body-format: (
    style: (fill: colors),
    outer: (
      stroke: it => {
        if it.level == 1 {
          auto
        } else {
          if it.n == it.n-last and it.n-last >= 2 {
            auto
          } else {
            (left: 1pt)
          }
        }
      },
      outset: it => {
        if it.level == 1 {
          auto
        } else {
          if it.n == it.n-last - 1 {
            (left: -.5em + 1pt, top: .8em, bottom: .7em)
          } else {
            (left: -.5em + 1pt, top: .8em)
          }
        }
      },
    ),
  ),
)

#[
  #set list(marker: tree-marker)
  #show: tree-list
  - Functional analysis
    - Metric space
      - Banach fixed point theorem
      - Arzela--Ascoli theorem
    - Banach space
      - Hanh--Banach theorem
        - Banach--Mazur thorem
        - Banach--Alaoglu theorem
      - Baire Category theorem
        - Banach--Steinhaus theorem
        - Open mapping theorem
          - Closed graph theorem
        - Closed range theorem
    - Hilbert space
      - Riesz representation theorem
      - Hilbert--Schmidt theorem
  - Banach Algbra
    - ...
]
