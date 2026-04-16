#import "../util/version.typ": package-version
#import "../util/basic-tool.typ": default-block-args, get-elem-label, get_current-par-args
#import "../util/identifier.typ": prevent-recursion-ID

/// To mark the first paragraph
#let par-state = state("__cdl_par-state__" + package-version, 0)

/// Implement `hanging-indent` and `line-indent`
/// In the body of lists, all text will be treated as paragraphs by default, but text wrapped in containers (such as `box`, any block-level containers (`block`), etc.) will be processed according to Typst's default rules (meaning, if they need to be interpreted as paragraphs, you need to add `parbreak()`).
#let par-box(
  it,
  line-indent: 0pt,
  hanging-indent: 0pt,
  line-inset: 0pt,
  hanging-inset: 0pt,
  first-line-indent: 0pt,
) = {
  par-state.update(it => it + 1)
  set par(..get_current-par-args(it))
  show pad: set block(..default-block-args, above: block.above, below: block.below)
  let _hanging-indent = (
    if hanging-indent == auto { it.hanging-indent } else { hanging-indent } + hanging-inset
  )
  let _line-indent = (
    if line-indent == auto { it.first-line-indent.amount } else { line-indent } + line-inset
  )
  if par-state.get() == 0 {
    // first line
    pad(left: _hanging-indent, rest: 0pt, {
      h(first-line-indent - _hanging-indent)
      h(0pt, weak: true)
      it.body
    })
  } else {
    pad(left: _hanging-indent, rest: 0pt, {
      h(_line-indent - _hanging-indent)
      h(0pt, weak: true)
      it.body
    })
  }
}


/// If the text of the first line is wrapped in a block-level container, regardless of whether that text is a paragraph, the following text needs to be interpreted as not being the first paragraph.
#let fix-first-par-state() = {
  par-state.update(it => {
    if it == 0 { it + 1 } else { it }
  })
}

/// Fix the line-indent of terms
#let fix-terms(doc) = {
  show terms.item: it => {
    if get-elem-label(it) == label(prevent-recursion-ID) {
      return it
    }
    par-state.update(0)
    [#terms.item(
        {
          it.term
        },
        {
          it.description
          parbreak()
          par-state.update(0)
        },
      )#label(prevent-recursion-ID)]
    par-state.update(1)
  }
  doc
}
