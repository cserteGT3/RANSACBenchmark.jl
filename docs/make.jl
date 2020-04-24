using Documenter, RANSACBenchmark

makedocs(
    modules = [RANSACBenchmark],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Tamás Cserteg",
    sitename = "RANSACBenchmark.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/cserteGT3/RANSACBenchmark.jl.git",
    push_preview = true
)
