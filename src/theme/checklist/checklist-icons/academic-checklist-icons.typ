// ---------- Helpers ----------
#let _svg-img(svg-str) = image(bytes(svg-str), height: 1em, width: 1em)

// ================= Basics =================

// [ ] To-Do: empty square (LaTeX \square)
#let to-do-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <rect x="2.5" y="2.5" width="11" height="11"/>
</svg>
```.text
// #let to-do(fill: none, solid: none) = context {
//   let svg = if type(fill) == color or fill == auto {
//     let _fill = if fill == auto { text.fill } else { fill }
//     to-do-svg.replace("currentColor", _fill.to-hex())
//   } else {
//     to-do-svg
//   }
//   if type(solid) == color {
//     svg = svg.replace("fill=\"none\"", "fill=\"" + solid.to-hex() + "\"")
//   }
//   _svg-img(svg)
// }

#let to-do = _svg-img(to-do-svg)

// [/] Incomplete: left half-filled square (progress)
#let incomplete-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <rect x="2.5" y="2.5" width="11" height="11"/>
  <path d="M2.5 2.5h5.5v11H2.5z" fill="currentColor" stroke="none"/>
</svg>
```.text
#let incomplete = _svg-img(incomplete-svg)

// [x] Done: square with checkmark (LaTeX \boxtimes)
#let done-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <rect x="2.5" y="2.5" width="11" height="11"/>
  <path d="M5 8.2l2.2 2.3L11 6"/>
</svg>
```.text
#let done = _svg-img(done-svg)

// [-] Canceled: square with horizontal bar (LaTeX \Boxminus)
#let canceled-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <rect x="2.5" y="2.5" width="11" height="11"/>
  <path d="M5 8h6"/>
</svg>
```.text
#let canceled = _svg-img(canceled-svg)

// [>] Forwarded: right arrow (LaTeX \rightarrow)
#let forwarded-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M2.5 8h9.5M8.5 4.5L12.5 8l-4 3.5"/>
</svg>
```.text
#let forwarded = _svg-img(forwarded-svg)

// [<] Scheduling: calendar (timetable)
#let scheduling-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <rect x="2.5" y="3.5" width="11" height="10"/>
  <path d="M2.5 6.8h11M5.5 1.8v3.2M10.5 1.8v3.2"/>
</svg>
```.text
#let scheduling = _svg-img(scheduling-svg)

// ================= Extras =================

// [?] Question: circle with drawn ? (pure path, no font)
#let question-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="8" cy="8" r="6.2"/>
  <path d="M6.05 6.15c0-1.35 1-2.35 2.2-2.35 1.3 0 2.3 1 2.3 2.25 0 .85-.45 1.45-1.2 1.95-.95.63-1.5 1.03-1.5 2.05"/>
  <circle cx="8.15" cy="12.2" r="0.85" fill="currentColor" stroke="none"/>
</svg>
```.text
#let question = _svg-img(question-svg)

// [!] Important: exclamation mark
#let important-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round">
  <path d="M8 3.2v6.2"/>
  <circle cx="8" cy="12.2" r="0.85" fill="currentColor" stroke="none"/>
</svg>
```.text
#let important = _svg-img(important-svg)

// [*] Star: asterisk (LaTeX \ast)
#let star-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round">
  <path d="M8 2.6v10.8M3.9 5.2l8.2 5.6M12.1 5.2L3.9 10.8"/>
</svg>
```.text
#let star = _svg-img(star-svg)

// ["] Quote: guillemet left (LaTeX \guilsinglleft)
#let quote-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M11 3.5L6.5 8 11 12.5"/>
  <path d="M6 3.5L1.5 8 6 12.5"/>
</svg>
```.text
#let quote = _svg-img(quote-svg)

// [l] Location: map pin
#let location-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M8 14.5s4-4.2 4-7a4 4 0 1 0-8 0c0 2.8 4 7 4 7z"/>
  <circle cx="8" cy="7.5" r="1.6"/>
</svg>
```.text
#let location = _svg-img(location-svg)

// [b] Bookmark: ribbon
#let bookmark-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M4.5 2.5h7v11l-3.5-2.5-3.5 2.5z"/>
</svg>
```.text
#let bookmark = _svg-img(bookmark-svg)

// [i] Information: dot + stem in circle (LaTeX \odot)
#let information-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round">
  <circle cx="8" cy="8" r="6.2"/>
  <circle cx="8" cy="5.5" r="0.85" fill="currentColor" stroke="none"/>
  <path d="M8 7.6v3.6"/>
</svg>
```.text
#let information = _svg-img(information-svg)

// [S] Savings: dollar sign (money)
#let savings-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M11.2 4.6H6.6a2.2 2.2 0 0 0 0 4.4h2.8a2.2 2.2 0 0 1 0 4.4H4.8"/>
  <path d="M8 2.5v11"/>
</svg>
```.text
#let savings = _svg-img(savings-svg)

// [I] Idea: light bulb (schematic)
#let idea-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M8 2.5a4.2 4.2 0 0 1 3.7 6.5c-.7 1.1-1.2 2-1.2 3V12H5.5v0c0-1-.5-1.9-1.2-3A4.2 4.2 0 0 1 8 2.5z"/>
  <path d="M5.8 14h4.4"/>
</svg>
```.text
#let idea = _svg-img(idea-svg)

// [p] Pros: plus sign (advantage)
#let pros-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round">
  <path d="M8 4v8M4 8h8"/>
</svg>
```.text
#let pros = _svg-img(pros-svg)

// [c] Cons: minus sign (disadvantage)
#let cons-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round">
  <path d="M3.5 8h9"/>
</svg>
```.text
#let cons = _svg-img(cons-svg)

// [f] Fire: flame with inner flame
#let fire-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M8 2.5c2 2.2 4 3.3 4 6a4 4 0 1 1-8 0c0-2.7 2-3.8 4-6z"/>
  <path d="M8 6.3c.9 1 .9 2.6 0 3.4"/>
</svg>
```.text
#let fire = _svg-img(fire-svg)

// [k] Key: key with ring and shaft
#let key-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="5.5" cy="8" r="2.8"/>
  <path d="M8 8h5M10.5 8v2.5M13 8v1.8"/>
</svg>
```.text
#let key = _svg-img(key-svg)

// [w] Win: trophy
#let win-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M5 2.5h6v4.8a3 3 0 0 1-6 0z"/>
  <path d="M5 3.8H3.2a2 2 0 0 0 1.8 2.4M11 3.8h1.8a2 2 0 0 1-1.8 2.4"/>
  <path d="M8 10.3v2.5M5.5 12.8h5"/>
</svg>
```.text
#let win = _svg-img(win-svg)

// [u] Up: arrow up (LaTeX \uparrow)
#let up-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M8 12.5v-9M4 7.5L8 3.5l4 4"/>
</svg>
```.text
#let up = _svg-img(up-svg)

// [d] Down: arrow down (LaTeX \downarrow)
#let down-svg = ```svg
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round">
  <path d="M8 3.5v9M4 8.5l4 4 4-4"/>
</svg>
```.text
#let down = _svg-img(down-svg)

// ================= Symbol Map =================

#let symbol-map = (
  // Basics
  " ": to-do,
  "/": incomplete,
  "x": done,
  "-": canceled,
  ">": forwarded,
  "<": scheduling,
  // Extras
  "?": question,
  "!": important,
  "*": star,
  "\"": quote,
  "l": location,
  "b": bookmark,
  "i": information,
  "S": savings,
  "I": idea,
  "p": pros,
  "c": cons,
  "f": fire,
  "k": key,
  "w": win,
  "u": up,
  "d": down,
)
