# main.jl
# Entry point. Load data, build instance, run LNS or ALNS, print results.
#
# Change the dataset and solver params here, then run:
#   julia main.jl

using Random
using CSV
using DataFrames
using Plots

include("structs.jl")
include("utils.jl")
include("Data_Read.jl")
include("compute_arrival_times_weighted_step.jl")
include("NN_based_greedy_algorithm.jl")
include("LNS.jl")
include("ALNS.jl")
include("LP.jl")
include("Plotting_functions.jl")


# ---- Load data ---------------------------------------------------------------
# Data_Read.jl populates variables like n01A, d01A, t01A, etc.
# Change "01A" to whichever dataset you want to run on.

dataset = "01A"
n  = n01A
d  = d01A
t  = t01A
h  = h01A
ei = ei01A
li = li01A
q  = q01A

inst = ProblemInstance(n, d, t, h, ei, li, q)


# ---- Generate initial solution -----------------------------------------------
# Nearest-neighbor greedy: fast but usually pretty bad, gives LNS somewhere to start

initial_route, _, _, _, _, _, _ = greedy_distance(n, d, t, ei, li, h)
initial_dist = compute_total_distance(initial_route, inst)
println("Initial route distance: $initial_dist")


# ---- Run LNS -----------------------------------------------------------------
# Pick one destructor - options: :random, :worst_cost, :worst_distance, :tw_narrow, :tw_wide

lns_params = SolverParams(
    15.0,    # time_limit (seconds)
    1e7,     # initial_temperature
    0.99,    # cooling_rate
    0.4,     # percentage_to_destroy
    0.4,     # wd (distance weight)
    0.4,     # wt (time weight)
    0.2      # wv (violation weight)
)

best_route_lns, best_cost_lns = run_lns(initial_route, inst, lns_params, destructor=:random)
println("\nLNS result:")
println("  route:    $best_route_lns")
println("  cost:     $(round(best_cost_lns, digits=2))")
println("  distance: $(compute_total_distance(best_route_lns, inst))")
println("  time:     $(compute_total_time(best_route_lns, inst))")


# ---- Post-process with LP ----------------------------------------------------
# Find optimal start time for the best route

opt_start, total_wait, total_viol, arrivals, wait_nodes, early_viol, late_viol =
    solve_start_time_lp(inst, best_route_lns)

println("\nLP post-processing:")
println("  optimal start time: $opt_start")
println("  total waiting time: $total_wait")
println("  total violations:   $total_viol")


# ---- Run ALNS (optional) -----------------------------------------------------
# Comment this out if you just want LNS

alns_params = ALNSParams(
    10000,   # max_iterations
    1e6,     # initial_temperature
    0.99,    # cooling_rate
    0.5,     # r (reaction factor for weight updates)
    0.4,     # percentage_to_destroy
    100      # segment_size (how often to update weights)
)

best_route_alns, best_cost_alns, stats, d_outcomes, c_outcomes =
    run_alns(initial_route, inst, alns_params)

println("\nALNS result:")
println("  cost:     $(round(best_cost_alns, digits=2))")
println("  distance: $(compute_total_distance(best_route_alns, inst))")

# save plots
plot_weights_evolution_destructors(stats.weight_snapshots_d)
savefig("results/destructors_weights.png")

plot_weights_evolution_constructors(stats.weight_snapshots_c)
savefig("results/constructors_weights.png")

plot_cumulative_outcomes_destructors(d_outcomes)
savefig("results/destructors_outcomes.png")

plot_cumulative_outcomes_constructors(c_outcomes)
savefig("results/constructors_outcomes.png")
