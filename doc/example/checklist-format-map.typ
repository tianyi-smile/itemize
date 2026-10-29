#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(checklist: true)
#show: el.config.checklist.with(
  enable-format: true,
  format-map: (
    ">": it => highlight(it),
    "-": it => strike(text(fill: rgb("#888888"), emph(it))), // Overrides the format-function of "-"
  ),
)
- [ ] #lorem(3)
- [-] #lorem(3)
- [>] #lorem(3)
