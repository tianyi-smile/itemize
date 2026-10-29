#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Memorandum with term headings
  #block(stroke: rgb("#e5e7eb"), radius: 10pt, inset: 10pt, width: 100%)[
    #block(above: 1em, below: 1em)
    #align(center)[
      #set text(size: 1.5em, weight: "black")
      #upper([Memorandum])
    ]
    #line(length: 100%)
    #show: el.default-enum-list.with(
      description-config: (
        term-format: it => {
          if it.elem-tag == "terms:list" {
            show: upper
            strong(it.body)
          } else {
            strong(it.body)
          }
        },
        term-width: it => {
          if it.elem-tag == "terms:heading" {
            2cm
          } else {
            auto
          }
        },
        separator: it => {
          if it.elem-tag == "terms:heading" {
            [*:*]
          } else if it.elem-tag == "terms:list" {
            [*.*#h(.5em, weak: true)]
          } else {
            auto
          }
        },
        style: it => if it.elem-tag == "terms:heading" {
          "horizontal"
        } else if it.elem-tag == "terms:list" {
          "hanging"
        } else {
          auto
        },
      ),
    )
    #set par(justify: true)
    - #el.item(elem-tag: "terms:heading")
      / TO: J. Halberstam, General Counsel
    - / From: A. R. Mendez
    - / Date: 24 October 2026
    - / Re: Whether the June 11 telemetry excursion constitutes a material breach

    + #el.item(elem-tag: "terms:list", whole-spacing: 1.6em, item-spacing: 1.5em, for-elem: true)
      / issue: Whether a single 7-hour, 22-minute temperature excursion ....
    + / rule: Materiality turns on the bargained-for specification, the degree of the deviation, and the foreseeability of the loss. See ....
    + / analysis: Three facts decide it. First, the tolerance was expressed as a hard number, not "approximately". Second, ....
    + / conclusion: The breach is material as pleaded; summary judgment on liability is defensible, with damages to be proved at trial.

    _Respectfully submitted for filing._
  ]
]
