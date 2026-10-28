#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  #import "@preview/deixis:0.2.0": *
  #show: deixis-setup-notes.with()
  = Pinned labels and cross-references
  #show: el.default-enum-list.with(
    fill: rgb("#2f6df6"),
    label-format: (
      it => {
        if type(it.tag) == dictionary {
          let is-deixis = it.tag.at("deixis", default: false)
          if is-deixis == true {
            deixis-attach(id: it.tag.id, it.body)
          } else {
            it.body
          }
        } else {
          it.body
        }
      }
    ),
  )
  #let pin-label(id) = {
    if type(id) == label {
      [#el.item(tag: (deixis: true, id: id))#id]
    } else {
      panic("pin: id must be a label")
    }
  }
  #let pin-to(..from) = context {
    let to-here = state("_to-here_", 0)
    let to = str(to-here.get())
    box(inset: 2pt, stroke: blue, deixis-attach(id: to, {
      set text(blue)
      from.pos().map(ref).join()
    }))
    for e in from.pos() {
      deixis-connect(
        from: (node: e),
        to: (node: to),
        connector: (heads: "stealth", stroke: blue + 1pt, route: "curve"),
      )
    }
    to-here.update(c => c + 1)
  }
  #set enum(numbering: "(1)")
  #show: el.config.ref
  + #pin-label(<a1>) #lorem(3)
  + #pin-label(<a2>) #lorem(3)
  + #pin-label(<a3>) #lorem(5)
  #lorem(5) #pin-to(<a1>, <a2>)  #lorem(2)

  #lorem(2) #pin-to(<a3>)  #lorem(2)
]
