module RANSACBenchmark

using LinearAlgebra

using RANSAC
using StaticArrays

export  sampleplane,
        sampleplanefromcorner,
        samplecylinder,
        samplesphere,
        samplecone,
        normalsforplot,
        noisifyvertices,
        noisifynormals,
        makemeanexample,
        examplepc2,
        examplepc3,
        examplepc4,
        examplepc5,
        examplepc6

include("exampleclouds.jl")

end # module
