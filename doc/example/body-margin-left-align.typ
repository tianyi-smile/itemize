#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  body-margin: 0pt,
  indent: (2.5em, auto),
  label-indent: it => { -it.label-width.current - it.e.body-indent },
)
#set enum(full: true)
+ Level One
  + Level Two
    + #lorem(2)
  + Level Two
+ Level One
