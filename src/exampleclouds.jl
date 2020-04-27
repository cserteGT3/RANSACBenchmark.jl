"""
    makemeanexample(nois = false; all = false)

Generate a definitely not random example.
"""
function makemeanexample(nois = false; all = false)
    vp1, np1 = sampleplane(SVector(0,0,0), SVector(0,0,1), SVector(1,3,0), (13.7, 9.58), (96, 112))
    vc1, nc1 = samplecylinder(SVector(0,0,1), SVector(0,0,0), 15, 15, (100, 150))
    vc2, nc2 = samplecylinder(SVector(-3,2,1), SVector(0.9, 1.8, -2.3), 7, 9, (150, 100))

    vs = vcat(vp1, vc1, vc2)
    ns = vcat(np1, nc1, nc2)
    if nois
        vs_n = noisifyvertices(vs, all)
        ns_n = noisifynormals(ns, 35)
        nsfp2_ = normalsforplot(vs_n, ns_n)
        return vs_n, ns_n, nsfp2_
    end
    nsfp_ = normalsforplot(vs, ns)
    return vs, ns, nsfp_
end

"""
    examplepc2(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)

Generate a definitely not random example consisting planes and spheres.
"""
function examplepc2(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)
    vp1, np1 = sampleplane(SVector(0,0,0), SVector(0,0,1), SVector(1,3,0), (13.7, 9.58), (96, 70))
    # vp2, np2 = sampleplane(SVector(7,2,1), SVector(1.9,2,0), SVector(0,1.2,1), (9.7, 15), (50, 75))
    vp3, np3 = sampleplane(SVector(15,-5,-10), SVector(.98,.02,0), SVector(0,1,0), (17.2, 11.1), (30, 42))


    vc1, nc1 = samplesphere(SVector(5.0,5,-1), 10, (72,85))
    vc2, nc2 = samplesphere(SVector(1.0,-7,8), 5, (45,57))
    shape_sizes = [96*70, 30*42, 72*85, 45*57]
    vs = vcat(vp1, vc1, vc2, vp3)
    ns = vcat(np1, nc1, nc2, np3)
    if nois
        vs_n = noisifyvertices(vs, all, vertscale)
        ns_n = noisifynormals(ns, mrotdeg)
        nsfp2_ = normalsforplot(vs_n, ns_n)
        return vs_n, ns_n, nsfp2_, shape_sizes
    end
    nsfp_ = normalsforplot(vs, ns)
    return vs, ns, nsfp_, shape_sizes
end


"""
    examplepc3(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)

Generate a definitely not random example consisting planes and spheres.
"""
function examplepc3(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)
    vp1, np1 = sampleplane(SVector(0,0,0), SVector(0,0,1), SVector(1,3,0), (13.7, 9.58), (96, 70))
    # vp2, np2 = sampleplane(SVector(7,2,1), SVector(1.9,2,0), SVector(0,1.2,1), (9.7, 15), (50, 75))
    vp3, np3 = sampleplane(SVector(15,-5,-10), SVector(.98,.02,0), SVector(0,1,0), (17.2, 11.1), (30, 42))

    cp1, cn1 = samplecylinder(SVector(0,0,1), SVector(2,3.8,7.3), 7.8, 9, (37,49) )
    cp2, cn2 = samplecylinder(normalize(SVector(2,1.3,-0.5)), SVector(4,16,-3.9), 3.79, 4, (57,29) )

    vc1, nc1 = samplesphere(SVector(5.0,5,-1), 10, (72,85))
    vc2, nc2 = samplesphere(SVector(1.0,-7,8), 5, (45,57))
    shape_sizes = [96*70, 30*42, 72*85, 45*57, 37*49, 57*29]

    vs = vcat(vp1, vc1, vc2, vp3, cp1, cp2)
    ns = vcat(np1, nc1, nc2, np3, cn1, cn2)
    if nois
        vs_n = noisifyvertices(vs, all, vertscale)
        ns_n = noisifynormals(ns, mrotdeg)
        nsfp2_ = normalsforplot(vs_n, ns_n)
        return vs_n, ns_n, nsfp2_, shape_sizes
    end
    nsfp_ = normalsforplot(vs, ns)
    return vs, ns, nsfp_, shape_sizes
end

function examplepc4(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)
    cp1, cn1 = samplecylinder(SVector(0,0,1), SVector(2,3.8,7.3), 7.8, 9, (37,49) )
    cp2, cn2 = samplecylinder(normalize(SVector(2,1.3,-0.5)), SVector(4,16,-3.9), 3.79, 4, (57,29) )

    vc1, nc1 = samplesphere(SVector(5.0,5,-1), 10, (72,85))
    vc2, nc2 = samplesphere(SVector(1.0,-7,8), 5, (45,57))
    shape_sizes = [96*70, 30*42, 72*85, 45*57, 37*49, 57*29]

    vs = vcat(vc2, vc1, cp1, cp2)
    ns = vcat(nc2, nc1, cn1, cn2)
    if nois
        vs_n = noisifyvertices(vs, all, vertscale)
        ns_n = noisifynormals(ns, mrotdeg)
        nsfp2_ = normalsforplot(vs_n, ns_n)
        return vs_n, ns_n, nsfp2_, shape_sizes
    end
    nsfp_ = normalsforplot(vs, ns)
    return vs, ns, nsfp_, shape_sizes
end

function examplepc5(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)
    cp1, cn1 = samplecylinder(SVector(0,0,1), SVector(2,3.8,7.3), 7.8, 9, (78,49) )
    cp2, cn2 = samplecylinder(normalize(SVector(2,1.3,-0.5)), SVector(4,16,-3.9), 3.79, 4, (57,78) )

    shape_sizes = [96*70, 30*42, 72*85, 45*57, 37*49, 57*29]

    vs = vcat(cp1, cp2)
    ns = vcat(cn1, cn2)
    if nois
        vs_n = noisifyvertices(vs, all, vertscale)
        ns_n = noisifynormals(ns, mrotdeg)
        nsfp2_ = normalsforplot(vs_n, ns_n)
        return vs_n, ns_n, nsfp2_, shape_sizes
    end
    nsfp_ = normalsforplot(vs, ns)
    return vs, ns, nsfp_, shape_sizes
end

"""
    examplepc6(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)

Generate a definitely not random example consisting planes and spheres.
"""
function examplepc6(nois = false; all = false, mrotdeg = 10, vertscale = 0.5)
    vp1, np1 = sampleplane(SVector(0,0,0), SVector(0,0,1), SVector(1,3,0), (13.7, 9.58), (96, 70))
    # vp2, np2 = sampleplane(SVector(7,2,1), SVector(1.9,2,0), SVector(0,1.2,1), (9.7, 15), (50, 75))
    vp3, np3 = sampleplane(SVector(15,-5,-10), SVector(.98,.02,0), SVector(0,1,0), (17.2, 11.1), (30, 42))

    cp1, cn1 = samplecylinder(SVector(0,0,1), SVector(2,3.8,7.3), 7.8, 9, (37,49) )
    cp2, cn2 = samplecylinder(normalize(SVector(2,1.3,-0.5)), SVector(4,16,-3.9), 3.79, 4, (57,29) )

    vc1, nc1 = samplesphere(SVector(5.0,5,-1), 10, (72,85))
    vc2, nc2 = samplesphere(SVector(1.0,-7,8), 5, (45,57))

    vco1, nco1 = samplecone(SVector(5,5.,-3.3), SVector(0,0,-1.), deg2rad(20), 6.5, (22,31))
    ax2 = normalize(SVector(0.5,-0.7,0.9))
    vco2, nco2 = samplecone(SVector(15,-7, 0.5), ax2, deg2rad(45), 9., (28,59))

    shape_sizes = [96*70, 30*42, 72*85, 45*57, 37*49, 57*29, 22*31, 28*59]

    vs = vcat(vp1, vc1, vc2, vp3, cp1, cp2, vco1, vco2)
    ns = vcat(np1, nc1, nc2, np3, cn1, cn2, nco1, nco2)
    if nois
        vs_n = noisifyvertices(vs, all, vertscale)
        ns_n = noisifynormals(ns, mrotdeg)
        nsfp2_ = normalsforplot(vs_n, ns_n)
        return vs_n, ns_n, nsfp2_, shape_sizes
    end
    nsfp_ = normalsforplot(vs, ns)
    return vs, ns, nsfp_, shape_sizes
end

## Whole new world

"""
    benchmarkcloud1(;vertexnoise::URN=nothing, normalnoise::URN=nothing, outliercount::URN=nothing)

Create the #1 benchmarkcloud.
All keyword arguments are: `URN = Union{Real,Nothing}`, where nothing means, that the given noise is not applied.
Uses `randn()`, say normally-distributed random numbers with mean 0 and standard deviation 1.

# Arguments:
- `vertexnoise::URN=nothing`: additional noise in the form of `noise=vertexnoise*randn(3)`.
- `normalnoise::URN=nothing`: rotate the normalvector by `normalnoise*randn()` degree.
- `outliercount::URN=nothing`: add plus `outliercount`% outlier points-normals to the point cloud, uniformly distributed in the 1.1*bounding box space.
"""
function benchmarkcloud1(;vertexnoise::URN=nothing, normalnoise::URN=nothing, outliercount::URN=nothing)
    Random.seed!(8764269842297186874)
    vp1, np1 = sampleplane(SV(-7.31, 2.17, 1.56), nSV(0, -1, 0.0), (13.7, 9.58), (17, 21))
    vp2, np2 = sampleplane(SV(-4.5317, 4.7, 9.2), nSV(0.5, 1, -1.0), (4.59, 3.17), (26, 12))
    fp1 = FittedPlane(SV(-7.31, 2.17, 1.56), nSV(0, -1, 0.0))
    fp2 = FittedPlane(SV(-4.5317, 4.7, 9.2), nSV(0.5, 1, -1.0))
    
    cp1, cn1 = samplecylinder(nSV(0,0,1), SV(2,3.8,7.3), 17.234, 9, (37,49) )
    cp2, cn2 = samplecylinder(nSV(2,1.3,-0.5), SV(4,16,-3.9), 1.79, 12.9, (37,17) )
    cn2 = cn2 .* -1
    fc1 = FittedCylinder(nSV(0,0,1), SV(2,3.8,7.3), 17.234, true)
    fc2 = FittedCylinder(nSV(2,1.3,-0.5), SV(4,16,-3.9), 1.79, false)
    
    vc1, nc1 = samplesphere(SV(5.0,5,-1), 10, (72,85))
    nc1 = nc1 .* -1
    vc2, nc2 = samplesphere(SV(1.0,-7,8), 5, (45,57))
    fs1 = FittedSphere(SV(5.0,5,-1), 10, false)
    fs2 = FittedSphere(SV(1.0,-7,8), 5, true)
    
    vco1, nco1 = samplecone(SV(5,5.,-7.3), nSV(0,0,-1.), deg2rad(20), 6.5, (22,31))
    nco1 = nco1 .* -1
    vco2, nco2 = samplecone(SV(15,-7, 0.5), nSV(0.5,-0.7,0.9), deg2rad(45), 9., (28,31))
    fco1 = FittedCone(SV(5,5.,-7.3), nSV(0,0,-1.), deg2rad(20), false)
    fco2 = FittedCone(SV(15,-7, 0.5), nSV(0.5,-0.7,0.9), deg2rad(45), true)
    
    vc3, nc3 = samplesphere(SV(-19.8,75,13.4), 2, (11,9))
    fs3 = FittedSphere(SV(-19.8,75,13.4), 2, true)
    vp3, np3 = sampleplanefromcorner(SV(20.0, -10, -10), nSV(0,1,1.0), nSV(-1.0,0,0), (50,50), (25,25))
    fp3 = FittedPlane(SV(20.0, -10, -10), np3[1])
    vco3, nco3 = samplecone(SV(-5.0, 20, -45.0), nSV(0,0,1.0), deg2rad(70), 37.19, (49,57))
    fco3 = FittedCone(SV(-5.0, 20, -45.0), nSV(0,0,1.0), deg2rad(70), true)
    vc4, nc4 = samplesphere(SV(19.8, -40, 35), 37.865, (59,63))
    fs4 = FittedSphere(SV(19.8, -40, 35), 37.865, true)
    
    cp3, cn3 = samplecylinder(nSV(-0.08,-0.06,1), SV(50., 50, -35.), 12.9, 73.5, (37,64))
    fc3 = FittedCylinder(nSV(-0.08,-0.06,1), SV(50., 50, -35.), 12.9, true)
    vp4, np4 = sampleplanefromcorner(SV(61.4, -73.59, -23.2), nSV(-0.2,1.0,-0.1), nSV(0,0.1,1), (124.4,92.2), (49,63))
    np4 = np4 .* -1
    fp4 = FittedPlane(SV(61.4, -73.59, -23.2), np4[1])
    cp4, cn4 = samplecylinder(nSV(-1,-0.06,0.1), SV(-15.28,63.4,13.4), 6.9, 27.5, (17,23))
    cn4 = cn4 .* -1
    fc4 = FittedCylinder(nSV(-1,-0.06,0.1), SV(-15.28,63.4,13.4), 6.9, false)
    
    va = [vp1, vp2, cp1, cp2, vc1, vc2, vco1, vco2, vc3, vp3, vco3, vc4, cp3, vp4, cp4]
    na = [np1, np2, cn1, cn2, nc1, nc2, nco1, nco2, nc3, np3, nco3, nc4, cn3, np4, cn4]
    sh = [fp1, fp2, fc1, fc2, fs1, fs2, fco1, fco2, fs3, fp3, fco3, fs4, fc3, fp4, fc4]
    vpf = vcat(va...)
    npf = vcat(na...)
    indexer = reduce(append!, [fill(i, size(va[i], 1)) for i in eachindex(va)])

    ntp = (vertexnoise=vertexnoise, normalnoise=normalnoise, outliercount=outliercount)

    vpf = applyvertexnoise!(vpf, vertexnoise)
    npf = applynormalnoise!(npf, normalnoise)
    vpf, npf, indexer = addoutliers!(vpf, npf, indexer, outliercount)
     
    return (vertices=vpf, normals=npf, version=v"1.1.0", indexes = indexer, shapes=sh, size=size(vpf, 1), noise=ntp)
    return vpf, npf
end

# advised values:
# - vertexnoise < 0.5
# - normalnoise < 10 or larger ;)
# - outliercount ?
