#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  #show: el.default-enum-list.with(
    // fill: white,
    checklist: true,
    description-config: (
      term-format: (strong,),
      separator: [ --- ],
    ),
  )
  #let my-box(stroke: black, body) = box(
    stroke: stroke + 0.2pt,
    width: 0.8em + 1pt,
    height: 0.8em + 1pt,
    fill: luma(95%),
    // radius: 50%,
    inset: 1pt,
    [#text(
      fill: stroke,
      body,
    )],
  )
  #show: el.config.checklist.with(
    baseline: "center",
    symbol-map: (
      ">": my-box(stroke: rgb("#2f6df6"), sym.triangle.stroked.r),
      ".": my-box(stroke: rgb("#f59e0b"), [●]),
      "x": my-box(stroke: rgb("#16a34a"), [✓]),
    ),
  )
  = Checklist with colored badges
  - [>]
    / Auth at the edge: Validate the token in the gateway; short-circuit with 401 on a miss.
  - [.]
    / Rate limit: #lorem(10)
  - [x]
    / Staged rollout: #lorem(10)
]
