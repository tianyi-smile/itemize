#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)


#show: el.config.ref.with(supplement: "Item")
#show link: set text(fill: orange)
#set enum(numbering: "(E1)", full: true)
#show: el.default-enum-list

Group axioms:
+ Associativity <ax:ass>
+ Existence of identity element <ax:id>
+ Existence of inverse element <ax:inv>

#set enum(numbering: "1.a", full: true)
#set math.equation(numbering: "(1.1)")
Another important list:
+ Newton's laws of motion are three physical laws that relate the motion of an object to the forces acting on it.
  + A body remains at rest, or in motion at a constant speed in a straight line, unless it is acted upon by a force.
  + The net force on a body is equal to the body's acceleration multiplied by its mass.
  + If two bodies exert forces on each other, these forces have the same magnitude but opposite directions. <newton-third>
+ Another important force is hooks law: <hook1>
  $ arrow(F) = -k arrow(Delta x). $ <eq:hook> #el.elabel[hook2]
+ $F = m a$ <eq:c> #el.elabel("eq:ma")

We covered the three group axioms @ax:ass, @ax:id and @ax:inv.

It is important to remember Newton's third law @newton-third[], and Hook's law @hook1. In @hook2 we gave Hook's law in @eq:hook. Note that @eq:ma[Conclusion] is a simlified version.
