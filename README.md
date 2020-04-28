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

Another suggestion for smaller cloud (though parameters must be set):
```julia
using RANSAC, RANSACBenchmark
bc2 = benchmarkcloud2([2, 4, 6, 8]);
pc = PointCloud(bc2.vertices, bc2.normals, 2);
p = RANSACParameters(τ=100, itermax=2000);
@time _, extr, _ = ransac(pc, p, true; reset_rand=true);
```
