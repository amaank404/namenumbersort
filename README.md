# namenumbersort
Short algorithm that provides a cmp function to compare two strings that may contain positive integers. It transforms the input strings to a sequence of strings and numbers and then sorts it.

It only contains one function namely `nameNumberCmp`. This function acts and works internally like system.cmp but it is comparitively smarter, instead of checking ascii codes for each character one by one it separates the given strings into a sequence of strings and integers all extraced from the original strings. Now one by one, these strings and integers are compared and then the program returns the final result.

Example:

```nim
import std/algorithm
import namenumbersort/namenumbersort

var mysequence = @["Episode 10a1", "Episode 11", "Episode 11.5", "Episode 11.4", "Episode 10a0.5", "Episode 3", "Episode 2"]
sort(mysequence, nameNumberCmp)
echo mysequnce
```

the sequence would be as follows thereafter

```nim
@[
  "Episode 2",
  "Episode 3",
  "Episode 10a0.5",
  "Episode 10a1",
  "Episode 11",
  "Episode 11.4",
  "Episode 11.5"
]
```