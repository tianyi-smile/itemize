#import "../lib.typ" as el
#let v-line-el = el.default-enum-list.with(
  body-format: (
    outer: (
      stroke: ((left: .2em + blue), auto),
      inset: ((left: .5em), auto),
      // outset: ((top: 15pt), auto),
    ),
  ),
)


#v-line-el[
  + #lorem(10)
    - #lorem(20)
    + - #lorem(20)
  + #lorem(10)

    #lorem(10)
  + #lorem(10)
]

#let orange-enum = el.default-enum.with(
  fill: orange,
  weight: "bold",
  size: (20pt, auto),
  body-format: (
    whole: (
      radius: (10pt, auto),
      fill: (orange.lighten(50%), auto),
      inset: (10pt, auto),
    ),
    inner: (
      radius: (10pt, auto),
      fill: (orange.lighten(70%), auto),
      inset: (5pt, auto),
    ),
  ),
)

#orange-enum[
  + #lorem(10)
    + #lorem(10)
    + #lorem(10)
  + #lorem(10)
  + #lorem(10)
]


#let grid-list = el.default-list.with(
  body-indent: (0pt, auto),
  enum-spacing: (auto, 15pt),
  body-format: (
    whole: (
      stroke: (1pt, auto),
      radius: (10pt, auto),
      fill: (rgb("#eee5e5"), auto),
      inset: ((bottom: 5pt), auto),
    ),
    outer: (
      stroke: it => {
        if it.level == 1 {
          if it.n >= 2 {
            (top: 1pt + gray)
          }
        } else {
          auto
        }
      },
      inset: ((bottom: 15pt, top: 15pt, rest: 10pt), auto),
    ),
    style: (
      size: (15pt, 12pt),
    ),
  ),

  label-format: ([], auto),
)

#[
  #set par(justify: true)
  #show: grid-list
  - #lorem(5)
    - #lorem(20)
    - #lorem(10)
  - #lorem(10)
    - #lorem(10)
  - #lorem(20)
    - #lorem(10)
]


#let background-list = el.default-list.with(
  label-format: ([], auto),
  body-format: (
    inner: (
      fill: (blue, auto),
      inset: (15pt, auto),
    ),
    style: (
      size: (25pt, auto),
      fill: white,
    ),
  ),
  is-full-width: false,
  enum-margin: (100pt, 0em),
  item-spacing: (15pt, auto),
)

#[
  #set par(justify: true)
  #show: background-list
  - Typst
  - Latex
  - MS-Word
  - WPS
]


#[
  #show: el.config.checklist.with(
    baseline: "center",
    enable-format: true,
    radius: 1em,
    extras: true,
    format-map: ("!": text.with(fill: blue, weight: "bold")),
  )
  #show: el.default-enum-list.with(fill: (blue, auto))
  - [ ] #lorem(5)
  - [x] #lorem(5)
  - [-] #lorem(5)
  - [/] #lorem(5)
  - [!] #lorem(5)
  - [?] #lorem(5)
  - [>] #lorem(5)
  - [p] #lorem(5)
  - [1] #lorem(5)
  - [Y] #lorem(5)
  - [a] #lorem(5)
]

#let circled-enum = el.default-enum.with(
  body-indent: (1.5em, auto),
  label-baseline: (.7em, auto),
  label-format: it => {
    if it.level == 1 {
      let c = if calc.odd(it.n) {
        green
      } else {
        blue
      }
      [#box(circle(width: 2em, stroke: c + 2pt), baseline: .7em)#h(-1.3em)#it.body]
    } else {
      it.body
    }
  },
)



#[
  #set text(12pt)
  #set par(justify: true)
  #show: circled-enum
  // <= 9 items
  + Euler's identity: $e^(i pi) + 1 = 0$

    #lorem(10)

  + Newton's Second Law of Motion: $bold(F) = m bold(a)$
    + #lorem(10)
    + #lorem(10)
  + Pythagorean Theorem: $c^2 = a^2 + b^2$
    - #lorem(10)
    - #lorem(10)
  + The Schrödinger Equation: $i planck.reduce frac(partial, partial t) Psi(bold(r), t) = hat(H) Psi(bold(r), t)$

    #lorem(10)
]


#let marker = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' xml:space='preserve' width='14' viewBox='0 0 50 50'%3E%3Cpath d='M46.5 12.5c-.4-1.1-1.3-1.8-2.2-2-4.2-4-11.6-4.3-17.1-4.1-6.9.3-13.9 2.1-19.4 6.5C2 17.5-2.4 25.7 2.5 32.6c2.2 3.2 5.5 4.9 9 5.5 3.3 1.7 6.7 3.3 10.2 4.4 7.8 2.3 17 1.6 23.2-4.3 7.3-7 4.8-17.3 1.6-25.7zm-20.2 2.7c.6 0 1.3 0 1.8.2 1.1.4 1.7 1.3 2 2.3-1-1.2-2.4-2.1-3.8-2.5zm-1.4 6.6c.9.9 1.3 2.2-.2 2.3-2 .2-1.1-1.9.2-2.3zm-11.8 9.8c-.6-.3-2.9-1.1-3.2-1.8-.2-.5 1.4-3.1 2.1-4.2.3.5.7 1 1.2 1.4 0 .3.1.6.2.8.5 1.9 1.5 3.1 2.9 4h-.2c-.8.1-1.6.1-2.5-.1-.2 0-.3 0-.5-.1zM24 36.4c1.6-.7 3-1.5 4.3-2.5.8.2 1.7.3 2.5.5 2.5.4 5.2.9 7.7.6-.9.6-2 1.1-3 1.4-3.9 1.3-7.7 1-11.5 0z'/%3E%3C/svg%3E"

// #image(bytes(marker))

#let marker0 = ```
<svg xmlns="http://www.w3.org/2000/svg" xml:space='preserve' width="14" height="14" viewBox="0 0 50 50">
<path d='M48.3 23.7c-1-9.9-9.9-15.6-18.9-17.8-8.2-2.1-18.8-2.6-24.6 4.8C.6 16.2 1 23.6 4.3 29.3c-.5 1-.8 2-1 3-.6 4 2 7.6 5.1 10 5.9 4.4 14 4.2 19.6-.4 1.5 0 2.9-.2 4.4-.5 1.8 0 3.5 0 5.3-.1 2.3-.1 3.5-1.9 3.5-3.7 4.5-3.3 7.7-8.2 7.1-13.9zM9.1 17.8c1.1-4.1 4.9-5.8 8.8-6.1.9-.1 1.9-.1 2.9-.1-3.2 1.6-6.3 4.6-8 7.4-.1.1-.1.2-.2.3-1.1.9-2.1 1.9-3 2.9-.2.2-.4.4-.5.6-.4-1.7-.5-3.3 0-3z' fill="#000" fill-rule="evenodd"></path>
</svg>
```
#let marker1 = ```
<svg xmlns="http://www.w3.org/2000/svg" xml:space='preserve' width="14" height="14" viewBox="0 0 50 50">
<path d='M46.5 12.5c-.4-1.1-1.3-1.8-2.2-2-4.2-4-11.6-4.3-17.1-4.1-6.9.3-13.9 2.1-19.4 6.5C2 17.5-2.4 25.7 2.5 32.6c2.2 3.2 5.5 4.9 9 5.5 3.3 1.7 6.7 3.3 10.2 4.4 7.8 2.3 17 1.6 23.2-4.3 7.3-7 4.8-17.3 1.6-25.7zm-20.2 2.7c.6 0 1.3 0 1.8.2 1.1.4 1.7 1.3 2 2.3-1-1.2-2.4-2.1-3.8-2.5zm-1.4 6.6c.9.9 1.3 2.2-.2 2.3-2 .2-1.1-1.9.2-2.3zm-11.8 9.8c-.6-.3-2.9-1.1-3.2-1.8-.2-.5 1.4-3.1 2.1-4.2.3.5.7 1 1.2 1.4 0 .3.1.6.2.8.5 1.9 1.5 3.1 2.9 4h-.2c-.8.1-1.6.1-2.5-.1-.2 0-.3 0-.5-.1zM24 36.4c1.6-.7 3-1.5 4.3-2.5.8.2 1.7.3 2.5.5 2.5.4 5.2.9 7.7.6-.9.6-2 1.1-3 1.4-3.9 1.3-7.7 1-11.5 5z' fill="#000" fill-rule="evenodd"></path>
</svg>
```
#let marker2 = ```
<svg xmlns="http://www.w3.org/2000/svg" xml:space='preserve' width="14" height="14" viewBox="0 0 50 50">
<path d='M46.4 16.2c-2.3-2.3-5.4-3.5-8.4-4.5-.5-.2-1.1-.3-1.6-.5-1.6-1.6-3.7-2.8-6.2-3.2-1-.2-1.9.1-2.5.6-.9-.3-1.8-.6-2.7-.8-3.2-1-6.4-1.8-9.5-.1-1 .5-1.9 1.2-2.7 2-6.4 1.4-11.7 5-12.4 12.7C0 27 1.9 31.5 4.9 34.9c.1.6.2 1.1.4 1.7 1 3.2 3.3 5.7 6.7 6.5 2.7.6 5.4-.2 7.9-1.2 3.3.4 6.7.3 9.9 0 6.5-.7 13.3-2.8 17.1-8.5 3.6-5.2 4-12.6-.5-17.2zm-17.3.9c2.1.4 4 1.7 4.7 3.8 0 .5-.1 1.1-.2 1.6-.3 1.4-.8 2.6-1.6 3.7-.7.2-1.5.1-2.3-.4-.8-.4-1.6-1-2.2-1.6-.4-.4-1.2-1.7-1.6-1.9 3.4 1.3 5.1-3 3.2-5.2zm-11.6 9.7c.2-1.9 1.1-3.9 2.3-5.5-.4 2.1.3 4.2 1.7 6 1.3 1.7 3.1 3.2 5 4.2-.2.1-.4.2-.6.4-.1 0-.1.1-.2.1-3.9.2-8.7-.8-8.2-5.2zm-6.4 3.1c.1.3.1.7.2 1 .2.6.4 1.2.7 1.8-.4-.2-.7-.5-1-.7.1-.8.1-1.4.1-2.1zm31.2-1.3c-.9 1.7-2.1 3.1-3.7 4.1 2-2.1 3.4-4.7 4-7.6.2-.7.3-1.4.3-2.1.6 1.5.5 3.3-.6 5.6z' fill="#000" fill-rule="evenodd"></path>
</svg>
```
#let marker = level => {
  if level == 0 {
    ([#image(bytes(marker0.text))], [#image(bytes(marker1.text))], [#image(bytes(marker2.text))], el.LOOP)
  } else {
    ([•], [‣], [–]).at(calc.rem-euclid(level - 1, 3))
  }
}

#import "@preview/shadowed:0.2.0": shadowed
#let todo-list = el.default-enum-list.with(
  label-baseline: (amount: "center", same-line-style: "center"),
  body-format: (
    outer: (
      stroke: ((0pt, (top: 1pt + blue)), auto),
      inset: (((right: 12pt), (top: 10pt, right: 12pt)), auto),
    ),
  ),
  item-spacing: (10pt, auto),
  indent: (12pt, auto),
)
#[
  #set par(justify: true)
  #set list(marker: marker)
  #shadowed(inset: (x: 0pt, y: 20pt))[
    #show: todo-list
    - Bread

      #lorem(20)
    - Milk
      + #lorem(10)
      + #lorem(10)
    - Eggs
      - #lorem(10)
      - #lorem(10)
    - + #lorem(10)
      + #lorem(10)
    - Sugar
    - Cake
    - Chocolate
    - Candy

  ]
]

#let linear-gradient = (color1, color2, n, m) => {
  gradient.linear(
    space: rgb,
    rgb(..(color1.components(alpha: false)), n),
    rgb(..color2.components(alpha: false), m),
    angle: 135deg,
  )
}
#let gradient-enum = el.default-enum.with(
  indent: (1em, 0em),
  item-format: it => {
    if it.level == 1 {
      shadowed(radius: 5pt, inset: (bottom: 12pt, top: -12pt, left: -2em), it.body)
    } else {
      it.body
    }
  },

  label-align: (bottom + right, auto),
  size: (1.5em, auto),
  label-format: it => {
    if it.level == 1 {
      let i = calc.rem-euclid(it.n, 10) + 1
      let (n, m) = if i in range(1, 6) {
        (i * 20%, i * 20%)
      } else {
        (100% - (i - 5) * 10%, 100% - (i - 5) * 10%)
      }
      box(
        fill: linear-gradient(rgb("#83e4e2"), rgb("#a2ed56"), 100%, 100%),

        height: 2em,
        width: 2em,
        radius: (bottom-right: 0pt, rest: .5em),
        box(
          height: 2em,
          width: 2em,
          radius: (bottom-right: 0pt, rest: .5em),
          inset: (bottom: 5pt, right: 3pt),
          fill: linear-gradient(rgb("#a2ed56"), rgb("#fddc32"), n, m),
          [*#it.body*],
        ),
      )
    } else {
      it.body
    }
  },
)

#[
  #lorem(10)
  #show: gradient-enum
  + #lorem(10)

    #lorem(20)
    + #lorem(5)
    + #lorem(5)
  + #lorem(20)
    - #lorem(5)
    - #lorem(5)
  + #lorem(10)
  10. #lorem(10)
  + #lorem(10)
]

#import "@preview/catppuccin:1.0.1": get-flavor
#let flavor = get-flavor("latte")
#let palette = flavor.colors

#let color-list = (
  palette.values().map(v => v.rgb)
)
#let fill-color(n) = {
  color-list.at(calc.rem-euclid(n, 13))
}
// #show: catppuccin.with(flavors.frappe)
#let square-enum = el.default-enum-list.with(
  label-baseline: (amount: "center", same-line-style: "center"),
  enum-config: (
    fill: (white, auto),
    label-align: (center + horizon, auto),
    label-width: (1.2em, auto),
    label-format: it => {
      if it.level == 1 {
        box(
          fill: fill-color(it.n),
          // inset: 5pt,
          radius: 3pt,
          width: 1.2em,
          height: 1.2em,
        )[#it.body]
      } else {
        it.body
      }
    },
    body-format: (
      style: (fill: rgb("#3c2948")),
    ),
  ),
)

#[
  #set enum(numbering: "1.a.")
  // <= 99
  #show: square-enum
  + #lorem(10)

    #lorem(20)

  + + #lorem(20)
    + #lorem(20)
  + #lorem(10)
  + #lorem(20)
  + - #lorem(10)
    - #lorem(10)
  +
  990. #lorem(20)

    #lorem(20)
]

#let cup-svg = ```
<svg xmlns="http://www.w3.org/2000/svg" xml:space='preserve' width="25pt" height="26pt" viewBox="0 0 25 26">
<path fill="#F26856" d="M21.215,1.428c-0.744,0-1.438,0.213-2.024,0.579V0.865c0-0.478-0.394-0.865-0.88-0.865H6.69
  C6.204,0,5.81,0.387,5.81,0.865v1.142C5.224,1.641,4.53,1.428,3.785,1.428C1.698,1.428,0,3.097,0,5.148
  C0,7.2,1.698,8.869,3.785,8.869h1.453c0.315,0,0.572,0.252,0.572,0.562c0,0.311-0.257,0.563-0.572,0.563
  c-0.486,0-0.88,0.388-0.88,0.865c0,0.478,0.395,0.865,0.88,0.865c0.421,0,0.816-0.111,1.158-0.303
  c0.318,0.865,0.761,1.647,1.318,2.31c0.686,0.814,1.515,1.425,2.433,1.808c-0.04,0.487-0.154,1.349-0.481,2.191
  c-0.591,1.519-1.564,2.257-2.975,2.257H5.238c-0.486,0-0.88,0.388-0.88,0.865v4.283c0,0.478,0.395,0.865,0.88,0.865h14.525
  c0.485,0,0.88-0.388,0.88-0.865v-4.283c0-0.478-0.395-0.865-0.88-0.865h-1.452c-1.411,0-2.385-0.738-2.975-2.257
  c-0.328-0.843-0.441-1.704-0.482-2.191c0.918-0.383,1.748-0.993,2.434-1.808c0.557-0.663,1-1.445,1.318-2.31
  c0.342,0.192,0.736,0.303,1.157,0.303c0.486,0,0.88-0.387,0.88-0.865c0-0.478-0.394-0.865-0.88-0.865
  c-0.315,0-0.572-0.252-0.572-0.563c0-0.31,0.257-0.562,0.572-0.562h1.452C23.303,8.869,25,7.2,25,5.148
  C25,3.097,23.303,1.428,21.215,1.428z M5.238,7.138H3.785c-1.116,0-2.024-0.893-2.024-1.99c0-1.097,0.908-1.99,2.024-1.99
  c1.117,0,2.025,0.893,2.025,1.99v2.06C5.627,7.163,5.435,7.138,5.238,7.138z M18.883,21.717v2.553H6.118v-2.553H18.883
  L18.883,21.717z M13.673,18.301c0.248,0.65,0.566,1.214,0.947,1.686h-4.24c0.381-0.472,0.699-1.035,0.947-1.686
  c0.33-0.865,0.479-1.723,0.545-2.327c0.207,0.021,0.416,0.033,0.627,0.033c0.211,0,0.42-0.013,0.627-0.033
  C13.195,16.578,13.344,17.436,13.673,18.301z M12.5,14.276c-2.856,0-4.93-2.638-4.93-6.273V1.73h9.859v6.273
  C17.43,11.638,15.357,14.276,12.5,14.276z M21.215,7.138h-1.452c-0.197,0-0.39,0.024-0.572,0.07v-2.06
  c0-1.097,0.908-1.99,2.024-1.99c1.117,0,2.025,0.893,2.025,1.99C23.241,6.246,22.333,7.138,21.215,7.138z"/>
</svg>
```


#let leaderboard = el.default-enum-list.with(
  label-baseline: (amount: "center", same-line-style: "center"),
  enum-spacing: (auto, 25pt),
  is-full-width: false,
  enum-margin: (30%, 0pt),
  indent: 0em,
  body-indent: (0em, 18pt, auto),
  // body-indent: 0em,
  label-width: (amount: -15pt, style: "auto"),
  list-config: (
    body-indent: 15pt,
    body-format: (
      outer: (
        radius: (10pt, auto),
        stroke: (1pt, auto),
        inset: ((x: 15pt, top: 15pt, bottom: 10pt), auto),
        fill: (rgb("#181c26"), auto),
        clip: (true, false),
      ),
      style: (
        fill: (white, auto),
        size: (18pt, 14pt),
      ),
    ),
    label-format: it => {
      if it.level == 1 {
        image(bytes(cup-svg.text))
      } else {
        it.body
      }
    },
  ),
  enum-config: (
    label-align: (center + horizon, auto),
    size: (1.2em, auto),
    fill: (n => rgb("#fa6855").darken(n * 10%), auto),
    label-format: (box.with(fill: white, height: 1em, width: 1em, radius: 1em), auto),
    body-format: (
      outer: (
        fill: (n => rgb("#fa6855").darken(n * 10%), auto),
        inset: ((y: 10pt), auto),
        outset: ((y: 10pt, x: 15pt), auto),
      ),
      style: (
        fill: (auto, auto),
        size: 18pt,
      ),
    ),
  ),
)

#[
  #set enum(numbering: "1.a")
  #show: leaderboard
  - Most active Players
    // - 1111
    + Jerry Wood #h(1fr) 315
    + Brandon Barnes #h(1fr) 301
    + 3333333 #lorem(20)
    + 111111
    + 33333333
  - ??????
    + 1111
    + 22222
]


#let circle-line-enum = el.default-enum-list.with(
  size: (2em, auto),
  fill: (red, auto),
  body-indent: .5em,
  // baseline: .5em,
  // label-baseline: 1.5em,
  label-align: (center + horizon, auto),
  label-format: (circle.with(stroke: 1pt + blue, fill: white, width: 1.5em), auto),
  // label-format: it => {
  //   if it.level == 1 {

  //     circle()[#align(center + horizon, it.body)]
  //   } else {
  //     it.body
  //   }
  // },
  body-format: (
    inner: (
      stroke: ((left: 2pt + blue), auto),
      // inset: ((left: 10pt), auto),
      outset: (((left: 2em, top: 0em), (left: 2em, top: 1.3em)), auto),
    ),
  ),
)

#[
  #set enum(numbering: "1.1")
  #show: circle-line-enum
  + #lorem(5) $vec(1, 1, 1, 1)$

    #lorem(20)
  + #lorem(20)
  + #lorem(20)
    + #lorem(20)

  + #lorem(20)
  + + #lorem(20)
    + #lorem(20)
  + #lorem(20)
]



#import "@preview/catppuccin:1.0.1": get-flavor
#let flavor = get-flavor("latte")
#let palette = flavor.colors

#let colors = (
  (
    "red",
    "yellow",
    "green",
    "blue",
    "mauve",
  ).map(c => flavor.colors.at(c).rgb)
    + (el.LOOP,)
)

#let tree-marker = (none, [$times.circle$], [$ast.circle$], [$star.filled$], [$times.div$])
#let tree-list = el.default-list.with(
  indent: ((0pt,),),
  fill: colors,
  item-spacing: .7em,
  enum-spacing: (auto, .7em),
  label-align: (center + horizon),
  label-baseline: .3em,
  body-indent: 0pt,
  label-format: it => {
    let marker-content = box(height: 1.2em, fill: white)[
      #set text(baseline: -.05em)
      #it.body #box(baseline: -.35em)[#line(length: 1em)]~]
    if it.level == 1 {
      none
    } else {
      marker-content
    }
  },
  body-format: (
    style: (fill: colors),
    outer: (
      stroke: it => {
        if it.level == 1 {
          auto
        } else {
          if it.n == it.n-last and it.n-last >= 2 {
            auto
          } else {
            (left: 1pt)
          }
        }
      },
      outset: it => {
        if it.level == 1 {
          auto
        } else {
          if it.n == it.n-last - 1 {
            (left: -.5em + 1pt, top: .8em, bottom: .7em)
          } else {
            (left: -.5em + 1pt, top: .8em)
          }
        }
      },
    ),
  ),
)

#[
  #set list(marker: tree-marker)
  #show: tree-list
  - Functional analysis
    - Metric space
      - Banach fixed point theorem
      - Arzela--Ascoli theorem
    - Banach space
      - Hanh--Banach theorem
        - Banach--Mazur thorem
        - Banach--Alaoglu theorem
      - Baire Category theorem
        - Banach--Steinhaus theorem
        - Open mapping thoerem
          - Closed graph theorem
        - Closed range theorem
    - Hilbert space
      - Riesz representation theorem
      - Hilbert--Schmidt theorem
  - Banach Algbra
    - ...
]


#let el-word = el.default-enum-list.with(
  label-width: (2em, 1em),
  label-align: (right, left),
)

#[
  #show: el-word
  + #lorem(20)
    + #lorem(20)
    - 111111111
    100. #lorem(20)
  + #lorem(20)
  100. #lorem(20)
  1000. #lorem(20)
  100000. #lorem(20)
]

#let align-label(doc) = el.default-enum-list(
  auto-label-width: auto,
  // debug
  // body-format: (
  //   inner: (
  //     stroke: (left: 1pt + blue) ,
  //     outset: it => {
  //       if it.n < it.n-last or it.level >= 2 {
  //         (bottom: 2em + it.n * 5em)
  //       }
  //     }
  //   ),
  // ),
  el.auto-label-item(form: (none, "all"), doc),
)

#set enum(numbering: "(1.1)")
#align-label[
  + #lorem(20)
    + #lorem(5)
    + #lorem(5)
      + #lorem(5)
      + #lorem(5)
    #lorem(5)
    100. #lorem(5)
      10. #lorem(20)
  + #lorem(5)
    + #lorem(5)
    #lorem(10)
    10. #lorem(5)
      20. #lorem(5)
]

#let resuming-enum(doc) = el.default-enum-list(
  auto-resuming: auto,
  auto-label-width: auto,
  // debug
  // body-format: (
  //   inner: (
  //     stroke: (left: 1pt + blue) ,
  //     outset: it => {
  //       if it.n < it.n-last or it.level >= 2 {
  //         (bottom: 2em + it.n * 5em)
  //       }
  //     }
  //   ),
  // ),
  el.auto-resume-enum(auto-resuming: true, el.auto-label-item(form: (none, "all"), doc)),
)
#set enum(numbering: "(1.I.i)")
#resuming-enum[
  + #lorem(20)
    + #lorem(5)
    + #lorem(5)
      + #lorem(5)
      + #lorem(5)
    #lorem(5)
    + + #lorem(5)
    + #lorem(5)
    + #lorem(20)
  + #lorem(5)
    + #lorem(5)
    #lorem(10)
    + #lorem(5)
      + #lorem(5)
]



