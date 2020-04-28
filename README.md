# RANSACBenchmark.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg) <!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/cserteGT3/RANSACBenchmark.jl.svg?branch=master)](https://travis-ci.com/cserteGT3/RANSACBenchmark.jl)
<!--
[![codecov.io](http://codecov.io/github/cserteGT3/RANSACBenchmark.jl/coverage.svg?branch=master)](http://codecov.io/github/cserteGT3/RANSACBenchmark.jl?branch=master)
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://cserteGT3.github.io/RANSACBenchmark.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-master-blue.svg)](https://cserteGT3.github.io/RANSACBenchmark.jl/dev)
-->

This package supports the benchmark of the [RANSAC.jl](https://github.com/cserteGT3/RANSAC.jl) package.

For quick copy-paste:
```julia
using RANSAC, RANSACBenchmark
bc1 = benchmarkcloud1();
pc = PointCloud(bc1.vertices, bc1.normals, 8);
p = RANSACParameters(τ=100, itermax=20_000);
@time _, extr, _ = ransac(pc, p, true; reset_rand=true);
size(extr)
```
An example:
```julia
julia> p = RANSACParameters(τ=100, itermax=80_000);

julia> @time _, extr, _ = ransac(pc, p, true; reset_rand=true); size(extr)
1154.026951 seconds (4.25 G allocations: 187.091 GiB, 2.05% gc time)
(13,)
```

Another suggestion for smaller cloud:
```julia
using RANSAC, RANSACBenchmark
bc2 = benchmarkcloud2();
pc = PointCloud(bc2.vertices, bc2.normals, 4);
p = RANSACParameters(τ=100, itermax=2000);
@time _, extr, _ = ransac(pc, p, true; reset_rand=true);
extr
```

Output:
```julia
julia> using RANSAC, RANSACBenchmark

julia> bc2 = benchmarkcloud2();

julia> pc = PointCloud(bc2.vertices, bc2.normals, 4);

julia> p = RANSACParameters(τ=100, itermax=2000);

julia> @time _, extr, _ = ransac(pc, p, true; reset_rand=true);
 13.821960 seconds (23.19 M allocations: 1.321 GiB, 6.04% gc time)

julia> extr
4-element Array{ScoredShape,1}:
 Scored: (Cand: (sphere, R: 5.0)), 2567 ps
 Scored: (Cand: (cone, ω: 0.7853981633974495)), 868 ps
 Scored: (Cand: (cylinder, R: 1.7900000000000027)), 629 ps
 Scored: (Cand: (plane)), 312 ps

julia> bc2.size
4376
```
