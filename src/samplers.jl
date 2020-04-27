"""
    sampleplane(vp, v1, v2, lengtht, sizet)

Create a tuple of points on a plane and their normals based on a point (`vp`) and
two vectors (`v1`, `v2`).

# Arguments:
- `vp`: a point of the plane.
- `v1`, `v2`: two vectors that define a plane.
- `lengtht`: tuple containing the length of the plane along each side.
- `sizet`: tuple containing the number of samples along each side.
"""
function sampleplane(vp, v1, v2, lengtht, sizet)
    @assert size(v1) == size(v2) == size(vp) "Vector's size must be the same!"
    v1n = normalize(v1)
    v2n = normalize(v2)
    n = cross(v1n, v2n)
    @assert norm(n) != 0 "Vectors can't be collinear!"
    s1, s2 = sizet
    @assert s1 > 0 && s2 > 0 "Should sample more than 0."
    s1l, s2l = lengtht
    pn = [n for i in 1:s1*s2]
    vpn = vp - (s1l*v1n + s2l*v2n)/2
    ps = [vpn + v1n*u/s1l + v2n*v/s2l for u in 1:s1 for v in 1:s2]
    return (ps, pn)
end

function sampleplanefromcorner(vp, v1, v2, lengtht, sizet)
    @assert size(v1) == size(v2) == size(vp) "Vector's size must be the same!"
    v1n = normalize(v1)
    v2n = normalize(v2)
    n = cross(v1n, v2n)
    @assert norm(n) != 0 "Vectors can't be collinear!"
    s1, s2 = sizet
    @assert s1 > 0 && s2 > 0 "Should sample more than 0."
    s1l, s2l = lengtht
    pn = [n for i in 1:(s1+1)*(s2+1)]
    ps = [vp + v1n*s1l*u/s1 + v2n*s2l*v/s2 for u in 0:s1 for v in 0:s2]
    return (ps, pn)
end

"""
    sampleplane(vp, n, lengtht, sizet)

Create a tuple of points on a plane and their normals based on a point (`vp`) and
a surface normal (`n`).

# Arguments:
- `vp`: a point of the plane.
- `n`: surface normal.
- `lengtht`: tuple containing the length of the plane along each side.
- `sizet`: tuple containing the number of samples along each side.
"""
function sampleplane(vp, n, lengtht, sizet)
    arbnorm = arbitrary_orthogonal2(n)
    norm2 = cross(n, arbnorm)
    return sampleplane(vp, arbnorm, norm2, lengtht, sizet)
end

"""
    samplecylinder(ax, vp, R, h, sizet)

Create a tuple of points on a cylinder and their normals based on an axis (`ax`),
a nullpoint (`vp`), radius and height.

# Arguments:
- `ax`: axis of the cylinder.
- `vp`: nullpoint of the cylinder.
- `R`: radius of the cylinder.
- `h`: height of the cylinder.
- `sizet`: tuple containing the number of samples along the circumference and the height.
"""
function samplecylinder(ax, vp, R, h, sizet)
    @assert size(ax,1) == size(vp,1) == 3 "Axis and nullpoint must be 3 dimensional."
    @assert R > 0 && h > 0 "Can't construct a line or circle."
    s1, s2 = sizet
    @assert s1 > 1 && s2 > 1 "Should sample more than 1."

    axn = normalize(ax)
    aort = normalize(arbitrary_orthogonal2(axn))

    function dontMul(M, v, kit)
        if kit == 0
            return v
        else
            return M^(kit-1)*v
        end
    end

    rotMat = rodriguesrad(axn, 2*π/s1)
    ps = [vp + R.*normalize(dontMul(rotMat, aort, i)) + ((j-1)*h/(s2-1)).*axn   for i in 1:s1 for j in 1:s2]
    ns = [normalize(p - vp - axn*dot( axn, p-vp )) for p in ps]
    return (ps, ns)
end

"""
    samplesphere(cp, R, sizet)

Create a tuple of points on a sphere and their normals.

# Arguments:
- `cp`: centerpoint of sphere.
- `R`: radius of the sphere.
- `sizet`: tuple containing the number of samples along two great circles.
"""
function samplesphere(cp, R, sizet)
    @assert R>0 "Can't construct sphere with radius < 0."
    s1, s2 = sizet
    @assert s1 > 2 && s2 > 2 "Should sample more than 2."
    r1 = range(0, π, length = s1+2)[2:end-1]
    r2 = range(0, 2π, length = s2+1)[1:end-1]
    vert = [cp + R*SVector{3}([sin(i)*cos(j), sin(i)*sin(j), cos(i)]) for i in r1 for j in r2]
    rV = SVector(0,0,R)
    append!(vert, [cp-rV,cp+rV])

    ns = similar(vert)
    for i in eachindex(ns)
        ns[i] = normalize(vert[i]-cp)
    end
    return vert, ns
end

function samplecone(ap, ax, opangr, h, sizet)
    # s1 along ax
    # s2 along circle
    s1, s2 = sizet

    surfl = h/cos(opangr/2)
    axn = normalize(ax)
    v1s = collect(range(0, stop=surfl, length=s1+1))
    popfirst!(v1s)
    # points along the axis
    alongax = [axn*i for i in v1s]
    aort = normalize(arbitrary_orthogonal2(axn))
    ns = normalize(cross(aort, axn))
    rM = rodriguesrad(aort, opangr/2)

    # one line along the surface of the cone
    alongsurf = [rM*s for s in alongax]
    alongsurfn = fill!(similar(alongsurf), rM*ns)
    rotMat = rodriguesrad(axn, 2*π/s2)
    # translate with the apex too
    ps = [rotMat^j*s + ap for s in alongsurf for j in 1:s2]
    final_ns = [rotMat^j*s for s in alongsurfn for j in 1:s2]
    return ps, final_ns
end

"""
    normalsforplot(verts, norms, arrowsize = 0.5)

Create an array of pair of points for plotting the normals with Makie.
Only the direction of the normals is presented, their size not.

# Arguments:
- `arrowsize`: scaling factor for the size of the lines.
"""
function normalsforplot(verts, norms, arrowsize = 0.5)
    @assert size(verts) == size(norms) "They should have the same size."
    as = arrowsize
    return [verts[i] => verts[i] + as .*normalize(norms[i]) for i in 1:length(verts) ]
end

"""
    noisifyvertices(verts, allvs, scalef = 1)

Add gaussian noise to vertices.
Random subset or all vertices can be selected.

# Arguments:
- `allvs::Bool`: adds noise to every vertice if true.
- `scalef::Real`: scale the noise from the [-1,1] interval.
"""
function noisifyvertices(verts, allvs, scalef = 1)
    randis = similar(verts)
    for i in eachindex(randis)
        randis[i] = (2*scalef) .*SVector(rand(eltype(eltype(verts)),3)...) .-1
    end
    allvs && return verts+randis
    bools = rand(Bool, size(verts))
    verts[bools] += randis[bools]
    return verts
end

"""
    noisifyv_fixed(verts, allvs, scalef = 1)

Fixed version of `noisifyvertices`.

# Arguments:
- `allvs::Bool`: adds noise to every vertice if true.
- `scalef::Real`: scale the noise from the [-1,1] interval.
"""
function noisifyv_fixed(verts, allvs, scalef = 1)
    randis = similar(verts)
    for i in eachindex(randis)
        randis[i] = (2*scalef) .*eltype(verts)(rand(3)) .- scalef
    end
    allvs && return verts+randis
    bools = rand(Bool, size(verts))
    verts[bools] += randis[bools]
    return verts
end

"""
    noisifynormals(norms, maxrot)

Add gaussian noise to normals.
Rotates the normals around a random axis with `maxrot` degrees.

# Arguments:
- `maxrot::Real`: maximum rotation in degrees.
"""
function noisifynormals(norms, maxrot)
    retn = similar(norms)
    # an array of random axes
    randis = similar(norms)
    for i in eachindex(randis)
        randis[i] = SVector{3}(rand(eltype(eltype(norms)),3))
    end
    # random rotations: array of random numbers
    randrots = maxrot.*rand(eltype(eltype(norms)), length(norms)).-maxrot/2
    for i in 1:length(retn)
        nr = normalize(randis[i])
        while norm(normalize(cross(norms[i], nr))) < 0.1
            nr = SVector{3}(normalize(rand(eltype(norms),3)))
        end
        crv = cross(nr, norms[i])
        rM = rodriguesdeg(crv, randrots[i])
        retn[i] = rM*norms[i]
    end
    return retn
end

## Whole new world

"""
    applynormalnoise!(normals, normalnoise::URN=nothing)

Rotates the normals around a random axis with `maxrot` degrees.
`URN = Union{Real,Nothing}`, where nothing means, that noise is not applied.
Uses `randn()`, say normally-distributed random numbers with mean 0 and standard deviation 1.

# Arguments:
- `normals`: an array of `SVector{3}`.
- `vertexnoise::URN=nothing`: additional noise in the form of a rotation around a random axis, with `normalnoise*randn()` degrees.
"""
function applynormalnoise!(normals, normalnoise::URN=nothing)
    normalnoise === nothing && return normals
    ftype = eltype(normals[1])
    for i in eachindex(normals)
        nr = normalize(SVector{3}(randn(ftype, 3)))
        while norm(normalize(cross(normals[i], nr))) < 0.1
            nr = normalize(SVector{3}(randn(ftype, 3)))
        end
        crv = cross(nr, normals[i])
        rM = rodriguesdeg(crv, normalnoise*randn(ftype))
        normals[i] = rM*normals[i]
    end
    return normals
end

"""
    applyvertexnoise!(vertices, vertexnoise::URN=nothing)

Apply gaussian noise to all vertices.
`URN = Union{Real,Nothing}`, where nothing means, that noise is not applied.
Uses `randn()`, say normally-distributed random numbers with mean 0 and standard deviation 1.

# Arguments:
- `vertices`: an array of `SVector{3}`.
- `vertexnoise::URN=nothing`: additional noise in the form of `noise=vertexnoise*randn(3)`.
"""
function applyvertexnoise!(vertices, vertexnoise::URN=nothing)
    vertexnoise === nothing && return vertices
    @assert vertexnoise > 0 "Only makes sense if you scale by a positive number."
    # apply noise to all points
    for i in eachindex(vertices)
        vertices[i] = vertices[i] + vertexnoise*randn(3)
    end
    return vertices
end

"""
    addoutliers!(vertices, normals, indexes, outliercount::URN=nothing)

Add outliers.
`URN = Union{Real,Nothing}`, where nothing means, that noise is not applied.
Outliers are added in the 1.2*bounding box space.
Outliers are marked in the index array with -1.

# Arguments:
- `vertices`: an array of `SVector{3}`.
- `normals`: an array of `SVector{3}`.
- `indexes`: an array of indexes, that store, that given points belong to wich primitive. Outliers are marked with -1.
- `outliercount::URN=nothing`: add plus `outliercount`% outlier points-normals to the point cloud, uniformly distributed in the 1.1*bounding box space.
"""
function addoutliers!(vertices, normals, indexes, outliercount::URN=nothing)
    outliercount === nothing && return (vertices, normals, indexes)
    @assert 0 <= outliercount <= 100 "Percent should be <= 0 <= 100."
    s = size(vertices,1)
    c = clamp(0, floor(Int, outliercount * s/100), s)
    c == 0 && return (vertices, normals, indexes)

    vtype = eltype(vertices)
    ntype = eltype(normals)
    
    aa, bb = RANSAC.findAABB(vertices)
    
    extend = 0.2
    absaabb = (1+extend) .* (bb - aa)
    delta = aa - (extend/2)*(bb-aa)
    
    outlv = [vtype(rand(3) .* absaabb+delta) for i in 1:c]
    append!(vertices, outlv)
    outln = [normalize(ntype(2 .*rand(3) .-1)) for i in 1:c]
    append!(normals, outln)
    append!(indexes, fill(-1, c))

    return (vertices, normals, indexes)
end