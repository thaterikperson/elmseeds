---
layout: post
title:  "Elm Benchmark"
date:   2017-04-20 13:47:00 -0400
categories:
label: ep-031
number: 31
tiny_description: Measure the speed of your elm functions.
---

Nothing settles a debate like cold, hard facts. If you wrote a function that you think is the fastest algorithm possible, the only way to know for sure is to test it. [Elm-Benchmark](http://package.elm-lang.org/packages/BrianHicks/elm-benchmark/latest) looks similar to [Elm-Test](https://elmseeds.thaterikperson.com/elm-test-2), but instead of checking for correctness, it checks for speed.

### Examples

**benchmarks/Main.elm**

```elm
module Main exposing (..)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Model exposing (..)


suite : Benchmark
suite =
    describe "Shuffle"
        [ Benchmark.compare "shufflers"
          (Benchmark.benchmark1 "array" shuffledDeck 0)
          (Benchmark.benchmark1 "naive" naiveShuffledDeck 0)
        ]


main : BenchmarkProgram
main =
    program suite
```

#### Links

* [Introducing elm-benchmark](https://www.brianthicks.com/post/2017/02/27/introducing-elm-benchmark/)
* [BrianHicks/elm-benchmark](http://package.elm-lang.org/packages/BrianHicks/elm-benchmark/latest)
* [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle)
