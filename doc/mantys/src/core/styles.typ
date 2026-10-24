#import "themes.typ": themable
#import "../util/utils.typ": dict-get, rawc, rawi


#let meta(name, l: none, r: none, kind: "arg") = themable(
  theme => {
    if l != none {
      rawc(theme.commands.symbol, l)
    }
    rawc(theme.commands.argument, name)
    if r != none {
      rawc(theme.commands.symbol, r)
    }
  },
  kind: kind,
)


// TODO: Use styles consistently
#let arg = meta.with(l: sym.chevron.l, r: sym.chevron.r, kind: "arg")


#let sarg = meta.with(l: ".." + sym.chevron.l, r: sym.chevron.r, kind: "sarg")


#let barg = meta.with(l: sym.bracket.l, r: sym.bracket.r, kind: "barg")


#let carg = meta.with(l: sym.brace.l, r: sym.brace.r, kind: "carg")


#let cmd(name, module: none, arg: none, color: "command") = themable(
  theme => {
    rawc(theme.commands.symbol, sym.hash)
    if module != none {
      rawc(theme.emph.module, module)
      rawc(theme.commands.symbol, ".")
    }
    if name != none {
      rawc(theme.commands.at(color, default: theme.commands.command), name)
    }
    if arg != none {
      if name != none {
        rawc(theme.commands.symbol, sym.dot.basic)
      }
      rawc(theme.commands.argument, arg)
    }
  },
  kind: "cmd",
)


#let lambda(args, ret) = themable(
  theme => {
    box({
      rawc(theme.commands.symbol, sym.paren.l)
      args.join(",")
      rawc(theme.commands.symbol, sym.paren.r + sym.arrow.r)
      ret
    })
  },
  kind: "lambda",
)

#let pill(color, body) = themable(theme => (theme.tag)(dict-get(theme, color, default: theme.muted.bg), body))
