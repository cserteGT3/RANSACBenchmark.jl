module RANSACBenchmark

using LinearAlgebra

using RANSAC
using StaticArrays
using Random

export  benchmarkcloud1

include("samplers.jl")
include("exampleclouds.jl")

end # module
