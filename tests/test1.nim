import unittest
import namenumbersort
import algorithm

test "Episode Names":
  var seq1: seq[string] = @["Episode 10a1", "Episode 11", "Episode 11.5", "Episode 11.4", "Episode 10a0.5", "Episode 3", "Episode 2"]
  sort(seq1, nameNumberCmp)
  check seq1 == @[
    "Episode 2",
    "Episode 3",
    "Episode 10a0.5",
    "Episode 10a1",
    "Episode 11",
    "Episode 11.4",
    "Episode 11.5"
  ]
