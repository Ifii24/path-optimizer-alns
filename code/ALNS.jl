# ALNS.jl
# Adaptive Large Neighborhood Search.
# Extends LNS by maintaining weights for each destructor and constructor,
# updating them every segment based on how often each one found good solutions.
#
# Usage:
#   inst   = ProblemInstance(n, d, t, h, ei, li, q)
#   params = ALNSParams(10000, 1e6, 0.99, 0.5, 0.4, 100)
#   best_route, best_cost, stats = run_alns(initial_route, inst, params)

using Random
using StatsBase
using Plots
using StatsPlots

include("utils.jl")
include("NN_based_greedy_algorithm.jl")
include("Random_destructor_function.jl")
include("Worst_Cost_Removal_Destructor.jl")
include("Worst_Distance_Removal_Destructor.jl")
include("Worst_TW_Removal_Narrow_Destructor.jl")
include("Worst_TW_Removal_Wide_Destructor.jl")
include("Cheapest_Insertion_Constructor.jl")
include("regret_insertion_k2_struct.jl")
include("regret_insertion_k3_struct.jl")
include("Plotting_functions.jl")
include("Data_Read.jl")
include("compute_arrival_times_weighted_step.jl")


# ---- Weight adaptation -------------------------------------------------------

# Roulette wheel selection - pick heuristic proportional to its weight
function roulette_selection(weights::Vector{Float64})::Int
    cumulative = cumsum(weights)
    r = rand() * cumulative[end]
    return findfirst(x -> x >= r, cumulative)
end

# Update weights based on scores earned this segment
# Formula: w_new = w_old * (1 - r) + r * (score / uses)
# Normalized so weights sum to 1
function update_weights(
    weights::Vector{Float64},
    scores::Vector{Float64},
    usage_counts::Vector{Int},
    r::Float64
)::Vector{Float64}
    efficiency = [scores[i] / max(usage_counts[i], 1) for i in eachindex(scores)]
    updated = weights .* (1.0 - r) .+ r .* efficiency
    return updated ./ sum(updated)  # normalize
end


# ---- Stats tracking ----------------------------------------------------------

# Tracks what happened at each iteration - global best, better, or worse accepted
mutable struct ALNSStats
    global_best::Vector{HeuristicOutcome}
    better::Vector{HeuristicOutcome}
    worse::Vector{HeuristicOutcome}
    weight_snapshots_d::Vector{WeightSnapshot}
    weight_snapshots_c::Vector{WeightSnapshot}
end

ALNSStats() = ALNSStats([], [], [], [], [])


# ---- Main ALNS loop ----------------------------------------------------------

"""
    run_alns(initial_route, inst, params)

Runs ALNS with 5 destructors and 3 constructors, updating weights every segment.

Returns (best_route, best_cost, stats).
"""
function run_alns(
    initial_route::Vector{Int64},
    inst::ProblemInstance,
    params::ALNSParams
)
    current_route = deepcopy(initial_route)
    _, _, _, _, _, _, _, _, _, _, _, violationsLate, _ = compute_arrival_times_weighted_step(
        current_route, inst.t, inst.h, inst.ei, inst.li
    )
    current_cost = inst.q * 0.4 * compute_total_distance(current_route, inst) +
                   0.4 * compute_total_time(current_route, inst) +
                   0.2 * violationsLate

    best_route = deepcopy(current_route)
    best_cost  = current_cost

    T = params.initial_temperature

    # 5 destructors: random, worst_cost, worst_distance, tw_narrow, tw_wide
    d_weights  = fill(0.2, 5)
    d_scores   = zeros(5)
    d_counts   = zeros(Int, 5)
    d_outcomes = [[0, 0, 0] for _ in 1:5]  # [global_best, better, worse_accepted]
    d_outcomes_cumulative = [[0, 0, 0] for _ in 1:5]

    # 3 constructors: cheapest insertion, regret-k2, regret-k3
    c_weights  = fill(1/3, 3)
    c_scores   = zeros(3)
    c_counts   = zeros(Int, 3)
    c_outcomes = [[0, 0, 0] for _ in 1:3]
    c_outcomes_cumulative = [[0, 0, 0] for _ in 1:3]

    # σ1 > σ2 > σ3: reward more for better outcomes
    σ1, σ2, σ3 = 10.0, 5.0, 2.0

    stats = ALNSStats()
    push!(stats.weight_snapshots_d, WeightSnapshot(0, copy(d_weights), copy(c_weights)))
    push!(stats.weight_snapshots_c, WeightSnapshot(0, copy(d_weights), copy(c_weights)))

    visited_solutions = Set{Tuple}()
    start_time = time()

    for iter in 1:params.max_iterations

        # pick heuristics
        d_idx = roulette_selection(d_weights)
        c_idx = roulette_selection(c_weights)

        # destroy
        if d_idx == 1
            remaining, removed = random_destructor(current_route, params.percentage_to_destroy)
        elseif d_idx == 2
            remaining, removed = Worst_Cost_Removal(current_route, params.percentage_to_destroy, 3)
        elseif d_idx == 3
            remaining, removed = Distance_Based_Removal(current_route, inst.d, params.percentage_to_destroy)
        elseif d_idx == 4
            remaining, removed = Worst_Removal_Narrow_TW(current_route, params.percentage_to_destroy, inst.ei, inst.li)
        elseif d_idx == 5
            remaining, removed = Worst_Removal_Wide_TW(current_route, params.percentage_to_destroy, inst.ei, inst.li)
        end
        d_counts[d_idx] += 1

        # reconstruct
        if c_idx == 1
            new_route, _ = Cheapest_Insertion_Constructor(remaining, removed, inst.n, inst.d, inst.t, inst.h, inst.ei, inst.li, inst.q)
        elseif c_idx == 2
            new_route, _ = Regret_Insertion_k2(remaining, removed, inst.d, inst.t, inst.h, inst.ei, inst.li, inst.q)
        elseif c_idx == 3
            new_route, _ = Regret_Insertion_k3(remaining, removed, inst.d, inst.t, inst.h, inst.ei, inst.li, inst.q)
        end
        c_counts[c_idx] += 1

        # one pass of 2-opt local search
        new_dist = compute_total_distance(new_route, inst)
        new_dist, new_route = local_search_2opt(new_route, new_dist, inst)

        # compute cost
        _, _, _, _, _, _, _, _, _, _, _, violationsLate, _ = compute_arrival_times_weighted_step(
            new_route, inst.t, inst.h, inst.ei, inst.li
        )
        new_cost = inst.q * 0.4 * new_dist +
                   0.4 * compute_total_time(new_route, inst) +
                   0.2 * violationsLate

        sol_tuple = Tuple(new_route)

        # only update rewards for solutions we haven't seen before
        if !(sol_tuple in visited_solutions)
            push!(visited_solutions, sol_tuple)
            now = time() - start_time

            if new_cost < best_cost
                best_route = deepcopy(new_route)
                best_cost  = new_cost
                d_outcomes[d_idx][1] += 1
                c_outcomes[c_idx][1] += 1
                push!(stats.global_best, HeuristicOutcome(iter, now, d_idx, c_idx, new_cost))
            elseif new_cost < current_cost
                d_outcomes[d_idx][2] += 1
                c_outcomes[c_idx][2] += 1
                push!(stats.better, HeuristicOutcome(iter, now, d_idx, c_idx, new_cost))
            else
                d_outcomes[d_idx][3] += 1
                c_outcomes[c_idx][3] += 1
                push!(stats.worse, HeuristicOutcome(iter, now, d_idx, c_idx, new_cost))
            end
        end

        current_route = deepcopy(new_route)
        current_cost  = new_cost

        # update weights at end of each segment
        if iter % params.segment_size == 0
            for i in eachindex(d_scores)
                d_scores[i] = σ1 * d_outcomes[i][1] + σ2 * d_outcomes[i][2] + σ3 * d_outcomes[i][3]
            end
            for i in eachindex(c_scores)
                c_scores[i] = σ1 * c_outcomes[i][1] + σ2 * c_outcomes[i][2] + σ3 * c_outcomes[i][3]
            end

            # accumulate for plots
            for i in 1:5, j in 1:3
                d_outcomes_cumulative[i][j] += d_outcomes[i][j]
            end
            for i in 1:3, j in 1:3
                c_outcomes_cumulative[i][j] += c_outcomes[i][j]
            end

            d_weights = update_weights(d_weights, d_scores, d_counts, params.r)
            c_weights = update_weights(c_weights, c_scores, c_counts, params.r)

            push!(stats.weight_snapshots_d, WeightSnapshot(iter, copy(d_weights), copy(c_weights)))
            push!(stats.weight_snapshots_c, WeightSnapshot(iter, copy(d_weights), copy(c_weights)))

            # reset segment counters
            d_scores .= 0.0; d_counts .= 0; d_outcomes .= [[0,0,0] for _ in 1:5]
            c_scores .= 0.0; c_counts .= 0; c_outcomes .= [[0,0,0] for _ in 1:3]
        end

        T *= params.cooling_rate
        if T < 1e-8
            println("temperature too low, stopping at iteration $iter")
            break
        end
    end

    elapsed = time() - start_time
    println("done — $(round(elapsed, digits=2))s, best cost: $(round(best_cost, digits=2))")
    println("global best improvements: $(length(stats.global_best))")

    return best_route, best_cost, stats, d_outcomes_cumulative, c_outcomes_cumulative
end
