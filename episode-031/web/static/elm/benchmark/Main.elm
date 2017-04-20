module Main exposing (..)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Model exposing (..)


suite : Benchmark
suite =
    describe "Shuffle"
        [ Benchmark.compare "shufflers"
            (Benchmark.benchmark1 "naive" naiveShuffledDeck 0)
            (Benchmark.benchmark1 "array" shuffledDeck 0)
        ]


main : BenchmarkProgram
main =
    program suite
