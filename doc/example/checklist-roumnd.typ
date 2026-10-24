#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#import "@preview/roumnd:0.1.0"
#let symbol-map = roumnd.icons.map(icon => context icon(foreground: luma(95%), background: text.fill))
#show: el.config.checklist.with(symbol-map: symbol-map)
#show: el.default-enum-list.with(checklist: true, fill: (blue, auto))
- [ ] #lorem(2)
- [x] #lorem(2)
- [/] #lorem(2)
- [>] #lorem(2)
- [!] #lorem(2)
