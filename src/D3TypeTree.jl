
isdefined(Base, :__precompile__) && __precompile__()

"""
Module for visualizing julia type hierarchies
"""
module D3TypeTree

#################################################################################
# Exports

export TypeTree

#################################################################################
# Imports

using JSON
using D3Trees

function wrap(t::Type)
	s = subtypes(t)
	if isempty(s)
		d = [string(fn) for fn in fieldnames(t)]
	else
		d = Dict()
		for t_inner in s
			if t_inner != t
				d[string(t_inner)] =  wrap(t_inner)
			end
		end
	end
	return d
end


function get_children(d::Dict, c = Array{Array{Any,1},1}(),n = Array{String,1}(),f = Array{String,1}())
	cc = Array{Any,1}()
	for (k,v) in d
		if isa(v,Dict) 
			get_children(v,c,n,f)
			push!(cc,String(k))
		elseif isa(v,Array)
			push!(c,[])
			push!(cc,String(k))
		end
		if !(String(k) in n)
			push!(n,String(k))
			push!(f,isa(v,Array) ? join(v,"\n") : "Abstract")
		end
	end
	push!(c,reverse(cc))
	c = [[findall(x->x==i, reverse(n))[1] for i in j] for j in reverse(c)]
	#c = reverse(c)
	return c[2:end], reverse(n), reverse(f)
end

function TypeTree(t::Type;browser="google chrome",init_expand=10)
	t = Dict(string(t)=>wrap(t))
	children, names, fields = get_children(t)
    tree = D3Tree(children,text = names,tooltip = fields,init_expand=10)
    inbrowser(tree,browser)
end

end #module
