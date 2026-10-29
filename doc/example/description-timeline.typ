#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let size = 1.4em
#let term-format = body => text(size: size, strong(body))
#let timeline = el.default-list.with(
  label-format: (circle(width: size, fill: blue), auto),
  label-baseline: ((amount: "center", relative-to: term-format([A])), auto),
  tight-item-mode: ("never-tight", auto),
  body-format: (
    whole: (
      stroke: ((left: gray + 2pt), auto),
      outset: ((left: -size / 2, bottom: .5em), auto),
    ),
  ),
  description-config: (
    style: "stacked",
    term-format: (term-format,),
    separator: (context block(above: 0pt, below: par.leading), auto),
  ),
)
#timeline[
  - / 2024: Product Project Approval
  - / 2025: Prototype development
  - / 2026: Officially released
]
