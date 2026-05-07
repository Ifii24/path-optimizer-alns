# LNS.jl
# Large Neighborhood Search with 5 destructor variants.
# Previously split across 5 separate files with massive amounts of copy-pasted code.
# Now all variants are here - you pick the destructor by passing a symbol.
#
# Usage:
#   inst = ProblemInstance(n, d, t, h, ei, li, q)
#   params = SolverParams(15.0, 1e7, 0.99, 0.4, 0.4, 0.4, 0.2)
#   best_route, best_cost = run_lns(initial_route, inst, params, destructor=:random)
#
# Available destructors: :random, :worst_cost, :worst_distance, :tw_narrow, :tw_wide

using Random
using StatsBase

include("utils.jl")
include("NN_based_greedy_algorithm.jl")
include("Random_destructor_function.jl")
include("Worst_Cost_Removal_Destructor.jl")
include("Worst_Distance_Removal_Destructor.jl")
include("Worst_TW_Removal_Narrow_Destructor.jl")
include("Worst_TW_Removal_Wide_Destructor.jl")
include("Cheapest_Insertion_Constructor.jl")
include("regret_insertion_k2_struct.jl")
include("Data_Read.jl")
include("compute_arrival_times_weighted_step.jl")
include("LP.jl")


# Apply whichever destructor was requested
function apply_destructor(
    route::Vector{Int64},
    inst::ProblemInstance,
    params::SolverParams,
    destructor::Symbol
)
    p = params.percentage_to_destroy
    if destructor == :random
        return random_destructor(route, p)
    elseif destructor == :worst_cost
        return Worst_Cost_Removal(route, p, inst.d, inst.t, inst.h, inst.ei, inst.li, 3)
    elseif destructor == :worst_distance
        return Distance_Based_Removal(route, inst.d, p)
    elseif destructor == :tw_narrow
        return Worst_Removal_Narrow_TW(route, p, inst.ei, inst.li)
    elseif destructor == :tw_wide
        return Worst_Removal_Wide_TW(route, p, inst.ei, inst.li)
    else
        error("Unknown destructor: $destructor. Choose from :random, :worst_cost, :worst_distance, :tw_narrow, :tw_wide")
    end
end


"""
    run_lns(initial_route, inst, params; destructor=:random)

Main LNS loop. Runs until time_limit is hit or temperature drops below 1e-8.

Returns (best_route, best_cost).
"""
function run_lns(
    initial_route::Vector{Int64},
    inst::ProblemInstance,
    params::SolverParams;
    destructor::Symbol = :random
)
    current_route = deepcopy(initial_route)
    _, _, _, _, _, _, _, _, _, _, _, violationsLate, _ = compute_arrival_times_weighted_step(
        current_route, inst.t, inst.h, inst.ei, inst.li
    )
    current_cost = compute_cost(current_route, violationsLate, inst, params.wd, params.wt, params.wv)

    best_route = deepcopy(current_route)
    best_cost  = current_cost

    T = params.initial_temperature
    start_time = time()
    iter = 0

    while time() - start_time < params.time_limit

        iter += 1

        # destroy
        remaining, removed = apply_destructor(current_route, inst, params, destructor)

        # reconstruct - using cheapest insertion
        # tried regret-k2 here too but cheapest was faster for most instances
        new_route, _ = Cheapest_Insertion_Constructor(
            remaining, removed, inst.n, inst.d, inst.t, inst.h, inst.ei, inst.li, inst.q
        )

        # one pass of 2-swap local search
        new_dist = compute_total_distance(new_route, inst)
        new_dist, new_route = local_search_2swap(new_route, new_dist, inst)

        # compute cost of new solution
        _, _, _, _, _, _, _, _, _, _, _, violationsLate, _ = compute_arrival_times_weighted_step(
            new_route, inst.t, inst.h, inst.ei, inst.li
        )
        new_cost = compute_cost(new_route, violationsLate, inst, params.wd, params.wt, params.wv)

        # acceptance
        if new_cost < best_cost
            best_route = deepcopy(new_route)
            best_cost  = new_cost
            current_route = deepcopy(best_route)
            current_cost  = best_cost
            println("iter $iter → new best: $(round(best_cost, digits=2))")
        elseif new_cost < current_cost
            current_route = deepcopy(new_route)
            current_cost  = new_cost
        else
            # simulated annealing: sometimes accept worse solutions
            Δ = new_cost - current_cost
            if rand() < exp(-Δ / T)
                current_route = deepcopy(new_route)
                current_cost  = new_cost
            end
        end

        T *= params.cooling_rate

        if T < 1e-8
            println("temperature too low, stopping at iteration $iter")
            break
        end
    end

    return best_route, best_cost
end
