#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Disclosure tree with expandable markers
  #set list(marker: [▸])
  #show: el.default-list.with(
    fill: rgb("#3a5ee6"),
    body-format: (
      whole: (
        stroke: (auto, (left: rgb("#a5abd9") + 1pt)),
      ),
    ),
    label-indent: (auto, 1em),
  )
  - RFC 9110 *HTTP*
    - #lorem(4)
    - #lorem(4)
      - #lorem(4)
  - RFC 9112 *Media Type*
    - #lorem(4)
    - #lorem(4)
      - #lorem(4)
]
