include("structs.jl")


# ---- Distance and time -------------------------------------------------------
function compute_total_distance(route::Vector{Int64}, inst::ProblemInstance)::Int64
    total = 0
    for i in 2:length(route)
        total += inst.d[route[i-1], route[i]]
    end
    return total
end

# Total travel + handling time along a route
function compute_total_time(route::Vector{Int64}, inst::ProblemInstance)::Int64
    total = 0
    for i in 2:length(route)
        total += inst.t[route[i-1], route[i]] + inst.h[route[i]]
    end
    return total
end

# Extra distance added by inserting a node (new_route vs original_route)
function compute_additional_distance(
    original_route::Vector{Int64},
    new_route::Vector{Int64},
    inst::ProblemInstance
)::Int64
    return compute_total_distance(new_route, inst) - compute_total_distance(original_route, inst)
end

# Extra time added by inserting a node
function compute_additional_time(
    original_route::Vector{Int64},
    new_route::Vector{Int64},
    inst::ProblemInstance
)::Int64
    return compute_total_time(new_route, inst) - compute_total_time(original_route, inst)
end


# ---- Cost function -----------------------------------------------------------

# The weighted cost used throughout - distance + time + late violations
# The weights wd, wt, wv come from SolverParams (or ALNSParams)
function compute_cost(
    route::Vector{Int64},
    violationsLate::Int64,
    inst::ProblemInstance,
    wd::Float64, wt::Float64, wv::Float64
)::Float64
    d = compute_total_distance(route, inst)
    t = compute_total_time(route, inst)
    return wd * inst.q * d + wt * t + wv * violationsLate
end


# ---- 2-opt local search ------------------------------------------------------

# Reverse the segment route[i:j] - standard 2-opt move
function two_opt_swap(route::Vector{Int64}, i::Int, j::Int)::Vector{Int64}
    new_route = copy(route)
    reverse!(new_route, i, j)
    return new_route
end

# Fast delta evaluation - only looks at the 2 edges that change, not the whole route
function delta_evaluation(route::Vector{Int64}, i::Int, j::Int, inst::ProblemInstance)::Int64
    old_dist = inst.d[route[i-1], route[i]] + inst.d[route[j], route[j+1]]
    new_dist = inst.d[route[i-1], route[j]] + inst.d[route[i], route[j+1]]
    return new_dist - old_dist
end

# Generate all 2-opt neighbors and their distances using delta evaluation
function two_opt_neighborhood(route::Vector{Int64}, inst::ProblemInstance)
    neighbors = Vector{Vector{Int64}}()
    dists = Vector{Int64}()
    current_dist = compute_total_distance(route, inst)

    for i in 2:(length(route) - 2)
        for j in (i+1):(length(route) - 1)
            neighbor = two_opt_swap(route, i, j)
            delta = delta_evaluation(route, i, j, inst)
            push!(neighbors, neighbor)
            push!(dists, current_dist + delta)
        end
    end
    return neighbors, dists
end

# Pick the best neighbor if it improves on current otherwise keep current
function select_best_neighbor(
    neighbors::Vector{Vector{Int64}},
    dists::Vector{Int64},
    current_route::Vector{Int64},
    current_dist::Int64
)
    best_idx = argmin(dists)
    if dists[best_idx] < current_dist
        return neighbors[best_idx], dists[best_idx]
    else
        return current_route, current_dist
    end
end

# One iteration of 2-opt local search
function local_search_2opt(route::Vector{Int64}, dist::Int64, inst::ProblemInstance)
    neighbors, dists = two_opt_neighborhood(route, inst)
    return select_best_neighbor(neighbors, dists, route, dist)
end


# ---- 2-swap local search -----------------------------------------------------

# Swap two nodes at positions i and j (different from 2-opt which reverses a segment)
function two_swap(route::Vector{Int64}, i::Int, j::Int)::Vector{Int64}
    new_route = copy(route)
    new_route[i], new_route[j] = new_route[j], new_route[i]
    return new_route
end

# Generate all 2-swap neighbors
function two_swap_neighborhood(route::Vector{Int64}, inst::ProblemInstance)
    neighbors = Vector{Vector{Int64}}()
    dists = Vector{Int64}()

    for i in 2:(length(route) - 2)
        for j in (i+1):(length(route) - 1)
            neighbor = two_swap(route, i, j)
            push!(neighbors, neighbor)
            push!(dists, compute_total_distance(neighbor, inst))
        end
    end
    return neighbors, dists
end

# One iteration of 2-swap local search
function local_search_2swap(route::Vector{Int64}, dist::Int64, inst::ProblemInstance)
    neighbors, dists = two_swap_neighborhood(route, inst)
    return select_best_neighbor(neighbors, dists, route, dist)
end
