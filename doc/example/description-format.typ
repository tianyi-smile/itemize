#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let desc-style = style => (description-config: (style: style), for-elem: true)
#show: el.default-enum-list.with(description-config: (
  term-format: it => {
    let format(body) = if it.style == "stacked" {
      strong(body)
      block(above: 0pt, below: par.leading)
    } else { emph(body) }
    format(it.body)
  },
  description-format: (text.with(fill: blue), none)
))
- #el.item(..desc-style("stacked"))
  / CPU: #lorem(10)
- / GPU: #lorem(10)
Paragraph
- #el.item(..desc-style("horizontal"))
  / CPU: #lorem(10)
- / GPU: #lorem(10)
