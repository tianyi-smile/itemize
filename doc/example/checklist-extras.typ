#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.config.checklist.with(extras: true)
#show: el.default-enum-list.with(checklist: true)
- [>] checked #lorem(2)
- [?] unchecked #lorem(2)
- [f] incomplete #lorem(2)
- [d] canceled #lorem(2)
