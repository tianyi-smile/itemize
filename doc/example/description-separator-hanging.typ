#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  tight-item-mode: ("never-tight", auto),
  description-config: (
    separator: it => {
      if it.style == "hanging" {(suffix: [#parbreak()])} else {auto}
    },
    term-format: (strong,),
    style: "hanging",
  ),
)
- / Alpha: #lorem(10)

    #lorem(10)
- / Beta: #lorem(10)
