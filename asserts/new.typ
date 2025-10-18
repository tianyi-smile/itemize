#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)
#[#sym.suit.club.filled], [#sym.suit.spade.filled], [#sym.suit.heart.filled]


#set list(marker: ([#sym.suit.club.filled], [#sym.suit.spade.filled], [#sym.suit.heart.filled]))
#show: el.default-enum-list
- 1111
  - 111111
    - 111111
- 111111
  - 11111



#show: el.default-enum-list.with(auto-label-width: "all")
+ #lorem(10)
+ #lorem(10)
  + #lorem(10)
  + #lorem(10)
  + #lorem(10)
    #show: el.default-enum-list.with(
      auto-label-width: auto,
    )
    + #lorem(10)
    #el.auto-label-item(form: ("enum", "all", "list"))[
      --------------
      100. #lorem(10)
        + #lorem(10)
        + #lorem(10)
          - #el.item[ABCD] #lorem(10)
            - #lorem(10)
            - #lorem(10)
          + QQQQQQQ
          - 11111111111111
          + 111111111111111111
            + 111111
            10. #lorem(10)
              + #lorem(10)
              + #lorem(10)
                + #lorem(10)
                + #lorem(10)
                  - #lorem(10)
                  + #lorem(10)
                + #lorem(10)
              + #lorem(10)
            + 22222222
            ------------
    ]

    + #lorem(10)
      + - #lorem(10)
        - #lorem(10)
  #lorem(10)
  + #lorem(10)
  + #lorem(10)
100.





#show: el.default-enum-list.with(auto-base-level: true)
#let marker = level => {
  if level == 0 {
    ([#sym.suit.club.filled], [#sym.suit.spade.filled], [#sym.suit.heart.filled], el.LOOP)
  } else if level == 1 {
    n => rotate(24deg * n, box(rect(stroke: 1pt + blue, height: 1em, width: 1em)))
  } else {
    [#sym.ballot.check.heavy]
  }
}
#set list(marker: marker)
- #lorem(5)
- #lorem(5)
  - #lorem(5)
  - #lorem(5)
    - #lorem(5)
    - #lorem(5)
  - #lorem(5)
  - #lorem(5)
  - #lorem(5)
- #lorem(5)
  - #lorem(5)
- #lorem(5)


#show: el.default-enum-list.with(label-format: it => it.n)
+ 1111
  + 1111
+ 3333
  + 333
    + 111111
