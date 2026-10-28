#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Timeline with circle nodes
  #let size = 1.4em
  #let term-format = body => text(fill: rgb("#3a5ee6"), size: size, strong(body))
  #let description-format = body => text(size: size + .2em, strong(body))
  #let timeline = el.default-list.with(
    label-format: (circle(width: size, fill: rgb("#3a5ee6")), auto),
    label-baseline: ((amount: "center", relative-to: term-format([A])), auto),
    tight-item-mode: ("never-tight", auto),
    body-format: (
      whole: (
        stroke: ((left: rgb("a5abd9") + 2pt), auto),
        outset: ((left: -size / 2, bottom: .5em), auto),
      ),
    ),
    description-config: (
      style: "stacked",
      term-format: (term-format,),
      description-format: (description-format,),
      separator: (context block(above: 0pt, below: size), auto),
    ),
  )
  #timeline[
    - / 2024: Product Project Approval
      - #lorem(2)
      - #lorem(2)
    - / 2025: Prototype development
      #lorem(10)
    - / 2026: Officially released
      #lorem(10)
  ]
]
