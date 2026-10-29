#import "../helper.typ": *

#let colors = splash.seaborn.dark.values()
#show: el.inline-enum-list.with(
  fill: colors,
  checklist: true,
  tight-mode: ("never-tight", auto),
  tight-item-mode: "always-tight",
  description-config: (
    term-format: (strong,),
  ),
)

= API Reference <sec:api>

== Main methods
#m.tidy-module(
  "Main methods",
  read("api-main.typ"),
  legacy-parser: true,
  first-heading-level: 1,
)

== Tool methods
#m.tidy-module(
  "Tool methods",
  read("api-tool.typ"),
  legacy-parser: true,
  first-heading-level: 1,
)

#m.tidy-module(
  "Tool methods",
  read("api-tool-config.typ"),
  module: "config",
  legacy-parser: true,
  first-heading-level: 1,
)

#m.tidy-module(
  "Tool methods",
  read("api-tool-adv.typ"),
  module: "adv",
  legacy-parser: true,
  first-heading-level: 1,
)
