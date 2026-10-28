#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Pseudocode listing with line numbers
  // https://typst.app/universe/package/lovelace
  #let no-number-flag = "_no-number_"
  #let listing-num = state("listing-num", 0)
  #let pseudocode(
    line-number-supplement: "line",
    line-numbering: "1",
    stroke: black + 1pt,
    stroke-inset: .3em,
    hooks: .3em,
    line-gap: 0.65em,
    body-indent: .5em,
    indent: .5em,
    body,
  ) = context {
    assert(type(line-numbering) == str or line-numbering == none)
    let sel = query(metadata.where(value: <code-end-flag>).after(here()))
    let max-width = 0pt
    if sel != () {
      let target = sel.first().location()
      let max-number = std.numbering(line-numbering, listing-num.at(target))
      max-width = measure([#max-number]).width
    }

    let stroke-thick = std.stroke(stroke).thickness
    if stroke-thick == auto {
      stroke-thick = 1pt
    }

    el.default-enum(
      label-width: max-width,
      body-indent: (body-indent, auto),
      item-spacing: line-gap,
      label-indent: it => {
        if it.level >= 2 {
          -max-width + indent
        } else {
          auto
        }
      },
      label-format: it => {
        if line-numbering != none {
          if it.tag != no-number-flag {
            context box(std.numbering(line-numbering, listing-num.get()))
          }
        }
      },
      body-format: (
        outer: (
          format: it => {
            if it.tag != no-number-flag {
              listing-num.update(c => c + 1)
            }
            it.body
          },
        ),
        whole: (
          stroke: (auto, (left: stroke)),
          outset: (auto, (left: -stroke-inset)),
          format: it => {
            it.body
            let hook-abs = hooks.to-absolute()
            if it.level >= 2 and hook-abs != 0pt {
              let box-width = hook-abs + stroke-inset + stroke-thick - stroke-thick / 2
              place(box(
                width: box-width,
                stroke: (bottom: stroke),
                outset: (left: -stroke-inset + stroke-thick / 2, bottom: -stroke-thick / 2),
              ))
            }
            if it.level == 1 {
              metadata(<code-end-flag>)
              listing-num.update(0)
            }
          },
        ),
      ),
      label-inset: it => {
        let parent = it.get
        let sum = 0pt
        for level in range(1, it.level) {
          sum += indent + parent(level).body-indent
        }
        -sum
      },
      supplement: it => {
        if it.tag != no-number-flag {
          [#line-number-supplement~#listing-num.at(it.target)]
        }
      },
      ref-numbering: "1",
      body,
    )
  }
  #show: el.config.ref
  #let no-number = el.item(tag: no-number-flag)

  #pseudocode(stroke: gray)[
    + do something
    + do something else
    + *while* still something to do <start>
      + do even more
      + *if* not done yet *then*
        + wait a bit
        + resume working
      + *else*
        + go home <important>
    + *end*
    + #no-number this line has _no number_
    + go to @start
    + *end*

    The relevance of the step in @important cannot be overstated.
  ]

]
