package day_1

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() {
  data := #load("./day_1.in", string)

  ids1, ids2: [dynamic]int
  defer delete(ids1)
  defer delete(ids2)

  for line in strings.split_lines_iterator(&data) {
    append(&ids1, strconv.atoi(line[:5]))
    append(&ids2, strconv.atoi(line[8:]))
  }

  slice.sort(ids1[:]) 
  slice.sort(ids2[:]) 

  diff := 0
  freq := make(map[int]int)
  defer delete(freq)

  for i in 0..<len(ids1) {
    diff += abs(ids1[i] - ids2[i])
    freq[ids2[i]] += 1
  }

  similarity := 0
  for id in ids1 {
    similarity += id * freq[id]
  }

  fmt.printfln("Diff score: %d, Similarity score: %d", diff, similarity)
}
