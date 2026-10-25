#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(auto-resuming: auto)
+ List one
#el.auto-resume-enum(auto-resuming: it => {
  if it.elem-tag == "resume" { true } else { false }
})[
  + Item one
  + Item two
    + Sub item one
    + Sub item two
  New paragraph
  + Item one // not resume
    + #el.item(elem-tag: "resume") Sub item // resume
]
+ List two // not resume
