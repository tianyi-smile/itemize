

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#let factorial-step = (..nums) => {
  let numbers = nums.pos()
  let n = numbers.len()
  if n >= 2 {
    return numbers.at(n - 2) + numbers.at(n - 1)
  }
}
#[
  Make enum numbers like factorial: \
  $a_n = a_(n - 2) + a_(n - 1)$, $a_1 = 1, a_2 = 1$.
  #show: el.default-enum-list.with(step: (factorial-step,))
  1. #lorem(2)
  1. #lorem(2)
  + #lorem(2)
  + #lorem(2)
  + #lorem(2)
  + #lorem(2)
]
#[
  Increment enum numbers by a step of 2:
  #show: el.default-enum-list.with(step: 2)
  1. #lorem(2)
  + #lorem(2)
  + #lorem(2)
  + #lorem(2)
]
