#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Simple tree with branch markers
  #let marker = [├─]
  #let last-marker = [└─]
  #let v-line = [│]
  #show: el.default-list.with(
    tight-mode: "always-tight",
    tight-item-mode: "always-tight",
    label-format: it => {
      let width = measure(marker).width
      let v-line-width = measure(v-line).width / 2
      if it.level != 1 {
        let offset = (it.level - 1)
        h(-(width + v-line-width) * offset)
        let content = {
          v-line
          h(-v-line-width + width)
        }
        content * offset
      }
      if it.n == it.n-last {
        last-marker
      } else {
        // full display
        marker
      }
    },
    label-align: left,
  )
  #block()[
    - docs
      - manual.pdf
    - src
      - core
      - foundation
        - math
        - text
      - lib.typ
    - typst.toml
  ]

]
