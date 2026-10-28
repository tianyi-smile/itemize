#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Editorial cards with gradient labels
  // rgb("#ff9a76"), rgb("#ff5b7f")
  #let linear-color(from, to) = gradient.linear(from, to, angle: 135deg)
  #let two-line-deck = el.default-list.with(
    label-format: it => {
      if type(it.tag) == dictionary {
        if "__" in it.tag {
          let (from, to) = it.tag
          box(fill: linear-color(from, to), width: 5.5em, height: 4em, radius: 10pt)
        } else {
          auto
        }
      } else {
        auto
      }
    },
    label-baseline: ("top-item", auto),
    body-indent: (0.85em, auto),
    body-format: (
      outer: (
        stroke: (rgb("#e5e7eb"), auto),
        inset: (.85em, auto),
        radius: (10pt, auto),
      ),
      inner: (
        inset: ((y: 5pt), auto),
        format: it => {
          set par(spacing: 0.65em, justify: true)
          it.body
        },
      ),
    ),
    description-config: (
      style: "stacked",
      term-format: (text.with(size: 0.8em, fill: rgb("#ff5b7f"), weight: "bold"),),
      description-format: (text.with(size: 1.1em, weight: "bold"),),
    ),
  )
  #let card(from, to) = {
    assert(type(from) == color and type(to) == color)
    el.item(tag: (from: from, to: to, "__": none))
  }
  #two-line-deck[
    - #card(rgb("#ff9a76"), rgb("#ff5b7f"))
      / DEEP DIVE: Why we split the monolith into 47 modules
      #lorem(10)
    - #card(rgb("#c176ff"), rgb("#9d5bff"))
      / BRIEFING: Your week in policy, in three changes that touch your wallet
      #lorem(16)
    - #card(rgb("#76a8ff"), rgb("#2930ec"))
      / FIELD NOTE: #lorem(8)
      #lorem(8)
  ]

]
