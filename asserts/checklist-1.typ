#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#show: el.default-enum-list.with(checklist: true)
- [x] checked #lorem(2)
- [ ] unchecked #lorem(2)
- [/] incomplete #lorem(2)
- [-] canceled #lorem(2)
