#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(checklist: true)
#show: el.config.checklist.with(enable-character: true)
- [B] #lorem(5)
- [A] #lorem(5)

#show: el.config.checklist.with(enable-character: false)
- [B] #lorem(5)
- [A] #lorem(5)
