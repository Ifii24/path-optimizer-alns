# LP.jl
# Linear program for finding the optimal start time given a fixed route.
# Minimizes waiting time and time window violations.
# Uses HiGHS solver via JuMP.
#
# Call after LNS/ALNS to post-process the best route found.

using JuMP
using HiGHS

include("utils.jl")


"""
    solve_start_time_lp(inst, route)

Given a fixed route, finds the optimal start time that minimizes
waiting time and time window violations.

Returns (optimal_start_time, total_waiting, total_violations,
         arrival_times, waiting_per_node, early_violations, late_violations)
"""
function solve_start_time_lp(inst::ProblemInstance, route::Vector{Int64})
    n = inst.n
    model = Model(HiGHS.Optimizer)
    set_silent(model)  # suppress solver output

    @variable(model, starting_time >= 0, Int)
    @variable(model, early_violation[1:(n+1)] >= 0, Int)
    @variable(model, late_violation[1:(n+1)] >= 0, Int)
    @variable(model, arrival_time[1:(n+1)] >= 0, Int)
    @variable(model, waiting_time[1:(n+1)] >= 0, Int)

    # minimize violations and waiting - weights from the thesis
    @objective(model, Min,
        0.45 * sum(early_violation) +
        0.45 * sum(late_violation) +
        0.1  * sum(waiting_time)
    )

    @constraint(model, arrival_time[1] == starting_time)
    @constraint(model, waiting_time[1] == 0)
    @constraint(model, [i = 2:(n+1)],
        arrival_time[i] == arrival_time[i-1] + inst.h[route[i-1]] +
                           inst.t[route[i-1], route[i]] + waiting_time[i-1]
    )
    @constraint(model, [i = 1:(n+1)],
        arrival_time[i] + waiting_time[i] + early_violation[i] >= inst.ei[route[i]]
    )
    @constraint(model, [i = 1:(n+1)],
        arrival_time[i] - late_violation[i] <= inst.li[route[i]]
    )

    optimize!(model)

    opt_start    = value(starting_time)
    early_viol   = [value(early_violation[i]) for i in 1:(n+1)]
    late_viol    = [value(late_violation[i])  for i in 1:(n+1)]
    total_viol   = sum(early_viol) + sum(late_viol)
    total_wait   = sum(value(waiting_time[i]) for i in 1:(n+1))
    wait_per_node = [value(waiting_time[i]) for i in 1:(n+1)]
    arrivals     = [value(arrival_time[i]) for i in 1:(n+1)]

    return opt_start, total_wait, total_viol, arrivals, wait_per_node, early_viol, late_viol
end
