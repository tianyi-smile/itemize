#let doc(code, preamble: "", scope: (:), style: "h") = {
  let hv = if style == "h" {
    (columns: (1fr, 1fr))
  } else {
    (rows: 2)
  }
  let inset = if style == "h" {
    (inset: ((right: 2.5pt, rest: 5pt), (left: 2.5pt, rest: 5pt)))
  } else {
    (inset: ((bottom: 2.5pt, rest: 5pt), (top: 2.5pt, rest: 5pt)))
  }
  set text(size: .8em)
  let _code = if type(code) == str { code } else { code.text }
  let _code = _code
    .replace("#set page(height: auto, margin: 15pt, width: 12cm)", "")
    .replace("#import \"../../lib.typ\" as el", "")
    .trim()

  let all = preamble.text + "\n" + _code
  block(
    radius: 0.5em,
    clip: true,
    {
      grid(
        ..hv,
        align: (top, top),
        ..inset,
        stroke: (1pt + gray.lighten(70%), 1pt + gray.lighten(70%)),
        // radius: (),
        fill: (gray.lighten(70%), gray.lighten(70%)),
        [
          #block(radius: 0.5em, inset: 6pt, fill: white, width: 100%)[
            #set par(justify: false)
            #set align(left)
            #raw(
              _code,
              lang: "typ",
              block: true,
            )
          ]
        ],
        [
          #block(radius: 0.5em, inset: 6pt, fill: white, width: 100%, breakable: false)[
            #set par(justify: false)
            #set align(left)
            #eval(
              all,
              mode: "markup",
              scope: scope,
            )
          ]
        ],
      )
    },
  )
}

#let example(code, scope: (:), style: "h") = {
  let preamble = if type(code) == content and code.func() == raw {
    `#import "../../lib.typ" as el`
  } else {
    `#import "@local/itemize:0.3.0" as el`
  }
  block(below: .65em)[*Example*]
  doc(code, preamble: preamble, scope: scope, style: style)
}

#import "mantys/src/mantys.typ" as m: argument, codesnippet, info-alert, sourcecode, warning-alert

#let dic-args(..schema) = {
  `(`
  terms(
    hanging-indent: 1.28em,
    indent: .64em,
    ..for (key, el) in schema.named() {
      let _default = "__none__"
      let _el = ()
      let dic = none
      if type(el) == array {
        for e in el {
          if type(e) == str {
            _el.push("\"" + e + "\"")
          } else {
            if type(e) == dictionary {
              if "default" in e {
                _default = e.default
              } else {
                if dic == none {
                  dic = dic-args(..e)
                } else {
                  //
                }
              }
            } else if type(e) == content and e.func() == raw {
              _el.push(e.text)
            } else {
              _el.push(e)
            }
          }
        }
      }
      (
        terms.item(
          m.styles.arg(key) + [:],
          if type(el) == array {
            if _default != "__none__" {
              strong(m.value(_default))
              h(1em)
            }
            m.dtypes(.._el)
            if dic != none { [| #dic] }
          } else {
            m.dtypes(el)
          },
        ),
      )
    },
  )
  `)`
}


#import "../lib.typ" as el
#import "@preview/splash:0.5.0"

#let theme-color = splash.seaborn.pastel
#let bp = m.type-box("base-property", theme-color.cyan)
#let lp = m.type-box("level-property", theme-color.purple)
#let llp = m.type-box("level-index-property", theme-color.orange)
