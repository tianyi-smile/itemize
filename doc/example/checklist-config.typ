#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.config.checklist.with(
  fill: (blue, auto),
  radius: (.5em, 0em),
  solid: gray.lighten(50%),
)
#show: el.default-enum-list.with(checklist: true)
- [x] checked #lorem(2)
- [ ] unchecked #lorem(2)
  - [x] checked (nested) #lorem(2)
- [/] incomplete #lorem(2)
- [-] canceled #lorem(2)
