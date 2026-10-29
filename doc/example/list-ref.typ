#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show link: set text(fill: orange)
#show: el.config.ref
#show: el.default-enum-list
- #el.item([*#sym.section*], supplement: [Assumption])<l:my> #lorem(15)
- #lorem(2)
See: @l:my.
