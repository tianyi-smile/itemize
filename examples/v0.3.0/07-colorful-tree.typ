#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Colorful tree with connector lines
  #import "@preview/catppuccin:1.1.0": get-flavor
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
  #let timeso = if sys.version >= version(0, 14, 0) { [$times.o$] } else [$times.circle$]
  #let asto = if sys.version >= version(0, 14, 0) { [$ast.o$] } else [$ast.circle$]
  #let tree-marker = ([$times.div$], timeso, asto, [$star.filled$])
  #let tree-list = el.default-list.with(
    fill: colors,
    item-spacing: .7em,
    whole-spacing: (auto, 1em),
    label-align: (center + horizon),
    body-indent: 0pt,
    label-format: it => {
      if it.level == 1 {
        none
      } else {
        box(height: 1.2em, fill: white)[
          #set text(baseline: -.05em)
          #it.body #box(baseline: -.35em)[#line(length: 1em)]~]
      }
    },
    body-format: (
      style: (fill: colors),
      outer: (
        stroke: it => {
          if it.level == 1 {
            auto
          } else {
            if (it.n == it.n-last and it.n-last >= 2) {
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
            if it.n-last == 1 {
              // only one item
              (left: -.5em + 1pt, top: .8em - 1pt, bottom: -100%)
            } else {
              if it.n == it.n-last - 1 {
                (left: -.5em + 1pt, top: .8em - 1pt, bottom: .7em)
              } else {
                (left: -.5em + 1pt, top: .8em - 1pt)
              }
            }
          }
        },
      ),
    ),
  )

  #tree-list[
    #set list(marker: tree-marker)
    - Functional analysis
      - Metric space
        - Banach fixed point theorem
        - Arzela--Ascoli theorem
      - Banach space
        - Hanh--Banach theorem
          - Banach--Mazur theorem
          - Banach--Alaoglu theorem
        - Baire Category theorem
          - Banach--Steinhaus theorem
          - Open mapping theorem
            - Closed graph theorem
          - Closed range theorem
      - Hilbert space
        // - Riesz representation theorem
        // - Hilbert--Schmidt theorem
    // - Banach Algebra
    //   - ...
    //     - ...
    //     - ...
  ]
]
