#import "../lib.typ" as el
#set page(height: auto, margin: 25pt, width: 15cm)
#set par(justify: true)

// See Fabio Ottaviani https://codepen.io/supah/pen/WwrJpw

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



#set enum(numbering: "1")
#set align(center)
#block[
  #set align(left)
  #leaderboard[
    - Most active Players
      // - 1111
      + Jerry Wood #h(1fr) 315
      + Brandon Barnes #h(1fr) 301
      + #lorem(2) #h(1fr) ???
      + #lorem(2) #h(1fr) ???
      + #lorem(2) #h(1fr) ???
    - #lorem(2)
      + #lorem(2)
      + #lorem(2)
  ]]


