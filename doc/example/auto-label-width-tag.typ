#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(auto-label-width: it => {
  if it.elem-tag == "auto-label" { auto }
})
+ Item one
  + #el.item(elem-tag: "auto-label") Sub Item one
  + Sub item two
+ Item one
  10. #el.item(elem-tag: "auto-label") Sub Item one
  + Sub item two
