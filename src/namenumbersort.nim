import std/strutils

type
  intStrHybridKind = enum
    hbStr
    hbInt
  intStrHybrid = object
    case kind: intStrHybridKind
    of hbStr:
      strVal: string
    of hbInt:
      intVal: int

proc splitIntoComponents(p: string): seq[intStrHybrid] =
  var buffer: string = ""
  var curmodeint: bool = false
  var final: seq[intStrHybrid] = @[]

  for x in p:
    if Digits.contains(x):
      if curmodeint: # Current mode is int, and we encountered a int
        buffer.add x
      else:
        curmodeint = true
        final.add intStrHybrid(kind: hbStr, strVal: buffer)
        buffer = ""
        buffer.add x
    else:
      if curmodeint: # Current mode is int and we encountered a string
        curmodeint = false
        final.add intStrHybrid(kind: hbInt, intVal: parseInt(buffer))
        buffer = ""
        buffer.add x
      else:
        buffer.add x
  if buffer.len != 0:
    if curmodeint:
      final.add intStrHybrid(kind: hbInt, intVal: parseInt(buffer))
    else:
      final.add intStrHybrid(kind: hbStr, strVal: buffer)
  return final


proc nameNumberCmp*(a: string, b: string): int =
  ## Takes two strings a, b and returns 
  ## 
  ## 1. an int less than 1 if a < b
  ## 2. 0 if a == b
  ## 3. an int greater than 1 if a > b
  ## 
  ## this function is best used in conjunction with std/algorithms
  ## 
  ## ```
  ## import std/algorithm
  ## import namenumbersort/namenumbersort
  ## 
  ## var mysequence = @["Episode 10a1", "Episode 11", "Episode 11.5", "Episode 11.4", "Episode 10a0.5", "Episode 3", "Episode 2"]
  ## 
  ## sort(mysequence, nameNumberCmp)
  ## 
  ## echo mysequnce
  ## ```
  ## 
  ## the sequence would be as follows thereafter
  ## 
  ## ```
  ## @[
  ##  "Episode 2",
  ##  "Episode 3",
  ##  "Episode 10a0.5",
  ##  "Episode 10a1",
  ##  "Episode 11",
  ##  "Episode 11.4",
  ##  "Episode 11.5"
  ## ]
  ## ```
  if a == b:
    return 0

  let ac = splitIntoComponents(a)
  let bc = splitIntoComponents(b)

  var idx = 0
  while ac.len > idx and bc.len > idx:
    assert ac[idx].kind == bc[idx].kind, "Their kinds do not match"
    if ac[idx].kind == hbInt:
      let val = system.cmp(ac[idx].intVal, bc[idx].intVal)
      if val != 0:
        return val
    else:
      let val = system.cmp(ac[idx].strVal, bc[idx].strVal)
      if val != 0:
        return val
    idx += 1

  if ac.len >= bc.len:
    return 1
  else:
    return -1