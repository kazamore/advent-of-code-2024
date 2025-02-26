package day_3

import "core:fmt"
import "core:strings"
import "core:unicode"

main :: proc() {
  input := #load("day_3.in", string)

  total := 0
  enabled := true
  length := len(input)

  idx := 0
  outer: for idx < length {
    if input[idx:min(length, idx + 4)] == "do()" {
      enabled = true
      idx += 4
      continue
    }

    if input[idx:min(length, idx + 7)] == "don't()" {
      enabled = false
      idx += 7
      continue
    }

    if !enabled {
      continue
    }

    if input[idx:min(length, idx + 4)] != "mul(" {
      continue
    }
    idx += 4

    left := 0
    for ; idx < length; idx += 1 {
      c := input[idx]
      digit := int(c - '0')
      if digit >= 0 && digit <= 9 {
        left = left * 10 + digit
      } else if c == ',' {
        break
      } else {
        continue outer
      }
    }
    idx += 1

    right := 0
    for ; idx < length; idx += 1 {
      c := input[idx]
      digit := int(c - '0')
      if digit >= 0 && digit <= 9 {
        right = right * 10 + digit
      } else if c == ')' {
        break
      } else {
        continue outer
      }
    }

    if idx < length && input[idx] == ')' {
      total += left * right
    }
  }

  fmt.println("Total:", total)
}
