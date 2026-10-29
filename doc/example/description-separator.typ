#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  description-config: (
    separator: it => {
      if it.style == "plain" {[*)*#h(.6em, weak: true)]} else {auto}
    },
    term-format: (strong,),
  ),
)
- / Alpha: #lorem(10)
- / Beta: #lorem(10)
