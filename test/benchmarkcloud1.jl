@testset "cloud 1" begin
    bc1 = benchmarkcloud1()
    p = RANSACParameters()
    vs = bc1.vertices
    ns = bc1.normals

    for i in eachindex(bc1.shapes)
        s = bc1.shapes[i]
        good_indexes = findall(x->x==i, bc1.indexes)
        goodsize = size(good_indexes, 1)
        curr_v = vs[good_indexes]
        curr_n = ns[good_indexes]

        if s isa FittedPlane
            sel, _ = RANSAC.compatiblesPlane(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        elseif s isa FittedCylinder
            sel, _ = RANSAC.compatiblesCylinder(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        elseif s isa FittedCone
            sel = RANSAC.compatiblesCone(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        elseif s isa FittedSphere
            sel, _, _ = RANSAC.compatiblesSphere(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        end
    end
end

## cloud 2
@testset "cloud 2" begin
    bc2 = benchmarkcloud2()
    p = RANSACParameters()
    vs2 = bc2.vertices
    ns2 = bc2.normals

    for i in eachindex(bc2.shapes)
        s = bc2.shapes[i]
        good_indexes = findall(x->x==i, bc2.indexes)
        goodsize = size(good_indexes, 1)
        curr_v = vs2[good_indexes]
        curr_n = ns2[good_indexes]

        if s isa FittedPlane
            sel, _ = RANSAC.compatiblesPlane(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        elseif s isa FittedCylinder
            sel, _ = RANSAC.compatiblesCylinder(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        elseif s isa FittedCone
            sel = RANSAC.compatiblesCone(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        elseif s isa FittedSphere
            sel, _, _ = RANSAC.compatiblesSphere(s, curr_v, curr_n, p)
            @test count(sel) == goodsize
        end
    end
end