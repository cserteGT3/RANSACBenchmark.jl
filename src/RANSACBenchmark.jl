module RANSACBenchmark

using LinearAlgebra

using RANSAC
using StaticArrays
using Random
using BenchmarkTools: @benchmark

export  benchmarkcloud1,
        benchmarkcloud2

export  benchmarksamplefunction


# abbreviations
const SV = SVector
nSV(v...) = normalize(SVector(v...))
const URN = Union{Real,Nothing}

include("samplers.jl")
include("samplebenchmark.jl")
include("exampleclouds.jl")

end # module
