# D3TypeTrees.jl

[![Build status](https://ci.appveyor.com/api/projects/status/gj8ndhle09g9dknt?svg=true)](https://ci.appveyor.com/project/claytonpbarrows/d3typetrees-jl)


julia type hierarchy visualization

## Installation

```
Pkg.add("https://github.com/claytonpbarrows/D3TypeTrees.jl")
```

## Example

The following will open a D3 visualization of the subtypes of the 'Number' type in your browser (default = 'google chrome').

```
TypeTree(Number)
```

![Tree](Number-tree.png)
