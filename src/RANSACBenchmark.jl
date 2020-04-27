module RANSACBenchmark

using LinearAlgebra

using RANSAC
using StaticArrays
using Random

export  benchmarkcloud1


# abbreviations
const SV = SVector
nSV(v...) = normalize(SVector(v...))
const URN = Union{Real,Nothing}

include("samplers.jl")
include("exampleclouds.jl")

end # module
