#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  checklist: true, // need
  description-config: (
    checklist: true, // need
  ),
)
+ / [ ]: #lorem(12)
+ / [-]: #lorem(8)
- / [x]: #lorem(8)
- / [/]: #lorem(12)
