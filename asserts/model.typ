#import "@preview/lilaq:0.6.0" as lq
#import "@preview/tiptoe:0.4.0"
#let line-arrow(x, y, ..args) = lq.line(
  tip: tiptoe.stealth,
  x,
  y,
  ..args,
)

#set page(height: auto, margin: 15pt, width: 14cm)

#[
  #show: lq.set-grid(
    stroke: none,
  )
  #set align(center)
  #lq.diagram(
    xaxis: none,
    yaxis: none,
    height: 20cm,
    width: 14cm,
    title: lq.title(position: bottom, [default-enum-list]),
    lq.rect(0, 13, height: 1, width: 10)[#align(center + horizon, [Preceding Text])],
    lq.line((0, 13), (0, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),
    lq.line((10, 13), (10, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),

    lq.line((3, 12), (3, 5.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: fuchsia)),

    lq.rect(1, 5.5, height: 6.5, width: 8, stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: red)),

    // enum-spacing.above
    line-arrow((5, 13), (5, 12)),
    lq.place(5.5, 12.5, align: left)[#set text(fill: black); whole-spacing.above],
    // Item 1: Paragraph 1
    lq.place(1.2, 12.25, align: left)[#set text(fill: fuchsia); label-width],
    lq.rect(1.5, 11.5, height: 0.5, width: 1, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],

    lq.line((1.5, 12), (1.5, 11.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: fuchsia)),
    line-arrow((1, 11.75), (1.5, 11.75), stroke: green),
    lq.place(0.1, 11.25, align: left)[#set text(fill: green); label-indent],

    line-arrow((10, 8.75), (9, 8.75)),
    lq.place(7.9, 8.5, align: left)[#set text(fill: black); body-margin.right],

    line-arrow((1, 8.75), (3, 8.75)),
    lq.place(0.8, 8.5, align: left)[#set text(fill: black); body-margin.left],

    lq.plot((2.99, 9, 9, 4, 4, 3, 3), (12, 12, 10.5, 10.5, 11.5, 11.5, 12.015), mark: none, stroke: 1.5pt),
    lq.place(5, 11.25, align: left)[Item 1: Paragraph 1],

    line-arrow((3, 11.75), (2.5, 11.75), stroke: green.darken(30%)),
    lq.place(1.95, 11.25, align: left)[#set text(fill: green.darken(30%)); body-indent],
    line-arrow((4, 10.75), (3, 10.75)),
    lq.place(2.5, 10.25, align: left)[hanging-indent],

    line-arrow((0, 11.75), (1, 11.75), stroke: purple),
    lq.place(0, 12., align: left)[#set text(fill: purple); indent],

    // par.spacing
    line-arrow((5, 10.5), (5, 9.5)),
    lq.place(5.5, 10, align: left)[par.spacing],
    // Item 1: Paragraph 2
    lq.plot((5, 9, 9, 4, 4, 5, 5), (9.5, 9.5, 8, 8, 9, 9, 9.515), mark: none, stroke: 1.5pt),
    lq.place(5, 8.75, align: left)[Item 1: Paragraph 2],
    line-arrow((5, 9.25), (3, 9.25)),
    lq.place(3.25, 9.5, align: left)[line-indent],

    // item-spacing
    line-arrow((5, 8), (5, 7)),
    lq.place(5.5, 7.5, align: left)[item-spacing],

    // Item 2: Paragraph
    lq.rect(1.5, 6.5, height: 0.5, width: 1, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],
    lq.plot((3, 9, 9, 4, 4, 3, 3), (7, 7, 5.5, 5.5, 6.5, 6.5, 7.015), mark: none, stroke: 1.5pt),
    lq.place(5, 6.25, align: left)[Item 2: Paragraph],

    // enum-spacing.below
    line-arrow((5, 5.5), (5, 4.5)),
    lq.place(5.5, 5, align: left)[#set text(fill: black); whole-spacing.below],

    lq.rect(0, 3.5, height: 1, width: 10)[#align(center + horizon, [Following Text])],
  )

]
