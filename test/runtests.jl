using RANSACBenchmark
using RANSAC
using Test
using LinearAlgebra
using StaticArrays: SVector

@testset "cone" begin
    include("cone.jl")
end

@testset "validate benchmark clouds" begin
    include("benchmarkcloud1.jl")
end
