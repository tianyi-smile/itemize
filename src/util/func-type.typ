#let func-seq = [].func()
#let func-counter-update = [#counter("_cdl").update(0)].func()
#let func-state-update = [#state("_cdl").update(none)].func()
// set text, set align, set par, have others?
#let func-styled = [#text(fill: red, [])].func()
#let func-content = [#context none].func()
#let func-layout = [#layout(_ => none)].func()


/// All the text-style functions
#let text-style-func = (
  highlight[].func(),
  overline[].func(),
  smallcaps[].func(),
  strike[].func(),
  sub[].func(),
  super[].func(),
  underline[].func(),
  strong[].func(),
  emph[].func(),
)

/// The function of `enum.item`, `list.item`, `enum`, `list`
#let item-func = (enum.item, list.item, enum, list) // ?? enum and list ????

/// block-level elements
#let block-level-elem = (
  //
  figure,
  heading,
  par, /**/
  //
  table,
  grid, /**/
  //
  block,
  //
  align,
  columns,
  layout,
  v,
  //
  move,
  pad,
  // place,
  //
  repeat,
  //
  rotate,
  scale,
  skew,
  stack,
  //
  outline,
  //
  circle,
  ellipse,
  rect,
  square,
  //
  curve,
  image,
  line,
  polygon,
  terms,
  terms.item,
)


/// blockable-level elements (`raw`, `math.equation`).
#let blockable-level-elem = (
  raw,
  math.equation,
)

/// Checks if the content is blank.
#let is-content-blank(e) = {
  return measure(e) == (0pt, 0pt)
}

/// Checks if the content is blank. (also including `v` and `place`).
#let is_blank-elem(e) = {
  // `pagebreak()` is illegel
  return (
    e in ([ ], parbreak(), colbreak(), auto, none, [])
      or e.func() in (func-counter-update, func-state-update, metadata)
      or e.func() in (v, place) // ???
  )
}

/// Checks if an element is styled.
#let is_styled(e) = {
  return e.func() == func-styled
}

/// Checks if an element has a text style.
#let is_text-styled(e) = {
  return e.func() in text-style-func
}

/// Checks if an element is an item (i.e. constructed by `enum` or `list`).
#let is_item(e) = {
  return e.func() in item-func
}

// Checks if an element is displayed inline.
#let is-inline-elem(e) = {
  e != none and measure([#h(0.01pt)#e]).width > measure(e).width
}

/// length type (length, relative, ratio)
#let length-type = (length, relative, ratio)
/// length type (length, relative, ratio, fraction)
#let length-type-with-fraction = (length, relative, ratio, fraction)
