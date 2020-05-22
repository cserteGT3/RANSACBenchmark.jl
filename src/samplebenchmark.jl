function benchmarksamplefunction(f, pc, params, percents=[99,90,60,30,10,1]; seed=1234)
    octree = RANSAC.buildoctree(pc)
    for percent in percents
        enablepoints!(pc, percent, seed)
        drawN = params.iteration.drawN
        sd = Vector{Int}(undef, drawN)
        Random.seed!(seed)
        countvalidsampling(f, pc, octree, params, 10000)
        Random.seed!(seed)
        result = @benchmark $f($sd, $pc, $octree, $params)
        display(result)
    end
end

function enablepoints!(pc, percent, seed = nothing)
    if ! (seed === nothing)
        Random.seed!(seed)
    end
    for i in eachindex(pc.isenabled)
        pc.isenabled[i] = rand() < percent/100 ? true : false
    end
    println("$(100*count(pc.isenabled)/pc.size) % is enabled")
    return pc
end

function countvalidsampling(f, pc, octree, params, n)
    drawN = params.iteration.drawN
    sd = Vector{Int}(undef, drawN)
    res = [f(sd, pc, octree, params) for i in 1:n]
    # valids
    ns = count(i->i[1], res)
    # false because simiar
    sims = count(i->((! i[1]) && i[2]==1), res)
    println("$(100*ns/n) % is valid; $(100*sims/(n-ns)) % of invalid is similar")
end