package day_2

import "core:fmt"
import "core:slice"
import "core:strconv"
import "core:strings"

is_safe :: proc(levels: []int) -> bool {
  if len(levels) < 2 {
    return true
  }
  increasing := levels[0] < levels[1]
  for i in 0 ..< len(levels) - 1 {
    diff: int
    if increasing {
      diff = levels[i + 1] - levels[i]
    } else {
      diff = levels[i] - levels[i + 1]
    }

    if diff < 1 || diff > 3 {
      return false
    }
  }

  return true
}

is_safe_dampened :: proc(levels: []int) -> bool {
  for i in 0 ..< len(levels) {
    if i == 0 {
      if is_safe(levels[1:]) {
        return true
      }
    } else if i == len(levels) - 1 {
      if is_safe(levels[:i]) {
        return true
      }
    }
    skipped := slice.concatenate([][]int{levels[:i], levels[i + 1:]})
    defer delete(skipped)
    if is_safe(skipped) {
      return true
    }
  }
  return false
}

main :: proc() {
  input := #load("day_2.ex", string)

  safe_reports := 0
  dampened_safe_reports := 0
  for line in strings.split_lines_iterator(&input) {
    parts := strings.split(line, " ")
    defer delete(parts)

    nums := make([]int, len(parts))
    defer delete(nums)
    for part, i in parts {
      nums[i] = strconv.atoi(part)
    }

    if is_safe(nums) {
      safe_reports += 1
    }
    if is_safe_dampened(nums) {
      dampened_safe_reports += 1
    }
  }

  fmt.println("Safe reports:", safe_reports)
  fmt.println("Dampened safe reports:", dampened_safe_reports)
}
