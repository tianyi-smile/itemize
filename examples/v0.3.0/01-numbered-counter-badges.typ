#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  #show: el.default-enum-list.with(
    fill: white,
    label-format: (
      width-style: (amount: 1.2em, stretched: true),
      height-style: (amount: 1.2em, stretched: true),
      fill: color.rgb("#2f6df6"),
      radius: 50%,
      inset: 2pt,
      align: center + horizon,
    ),
    description-config: (
      style: "horizontal",
      term-format: (strong,),
    ),
  )
  #set enum(numbering: "1")
  = Numbered counter badges
  + / Auth at the edge: Validate the token in the gateway; short-circuit with 401 on a miss.
  + / Rate limit: #lorem(10)
  + / Staged rollout: #lorem(10)
]
