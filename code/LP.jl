import Pkg
Pkg.add("HiGHS")


using JuMP
using HiGHS


# Load your actual data
using Pkg
using CSV
using DataFrames
using Dates
using Random

#include("Data_Read.jl")

function compute_total_time(solution::Vector{Int64}, t::Matrix{Int64}, h::Vector{Int64})
    total_time = 0
    for i in 2:(length(solution))
        total_time += t[solution[i-1], solution[i]] + h[solution[i]]
    end
    return total_time
end

function compute_total_distance(solution::Vector{Int64}, d::Matrix{Int64})
    total_distance = 0
    for i in 2:(length(solution))
        total_distance += d[solution[i-1], solution[i]]
    end
    return total_distance
end

# n is the number of nodes, including the terminal. The terminal is only countet once.
function LP(n, route, t, h, e, l)

    model = Model(HiGHS.Optimizer);

    @variable(model, starting_time >= 0, Int);
    @variable(model, early_violation[1:(n+1)] >= 0, Int);
    @variable(model, late_violation[1:(n+1)] >= 0, Int);
    @variable(model, arrival_time[1:(n+1)] >= 0, Int);
    @variable(model, waiting_time[1:(n+1)] >= 0, Int);            

    @objective(model, Min, 0.45*sum(early_violation) + 0.45*sum(late_violation) + 0.1*sum(waiting_time));

    @constraint(model, arrival_time[1] == starting_time);
    @constraint(model, waiting_time[1] == 0);
    @constraint(model, [i = 2:(n+1)], arrival_time[i] == arrival_time[i-1] + h[route[i-1]] + t[route[i-1],route[i]] + waiting_time[i-1]);
    @constraint(model, [i = 1:(n+1)], arrival_time[i] + waiting_time[i] + early_violation[i] >= e[route[i]]);
    @constraint(model, [i = 1:(n+1)], arrival_time[i] - late_violation[i] <= l[route[i]]);

    optimize!(model)

    optimal_start_time = value(starting_time)
    early_violations = [value(early_violation[i]) for i in 1:n+1]
    late_violations = [value(late_violation[i]) for i in 1:n+1]
    violation = sum(value(early_violation[i]) for i in 1:n+1)+sum(value(late_violation[i]) for i in 1:n+1)
    waiting = sum(value(waiting_time[i]) for i in 1:n+1)
    waiting_node = [value(waiting_time[i]) for i in 1:n+1]
    arrival = [value(arrival_time[i]) for i in 1:n+1]

    return optimal_start_time, waiting, violation, arrival, waiting_node, early_violations, late_violations
end


#=
# wt = 2643
route1 = [1, 73, 55, 17, 6, 8, 9, 64, 65, 62, 56, 61, 71, 72, 67, 66, 76, 74, 75, 68, 69, 70, 79, 77, 78, 81, 80, 82, 83, 84, 85, 86, 87, 88, 90, 89, 91, 92, 93, 94, 102, 99, 100, 101, 98, 97, 96, 95, 38, 27, 28, 29, 30, 31, 37, 34, 33, 35, 36, 32, 39, 44, 46, 45, 43, 42, 41, 40, 18, 19, 20, 21, 26, 23, 25, 24, 22, 7, 10, 11, 12, 50, 13, 15, 14, 63, 16, 60, 59, 57, 58, 5, 4, 3, 54, 53, 52, 51, 49, 48, 47, 2, 1]
# wt = 1105
route2 = [1, 73, 4, 5, 55, 58, 59, 60, 16, 63, 18, 44, 19, 10, 9, 64, 65, 62, 56, 61, 57, 71, 72, 66, 67, 39, 74, 75, 76, 69, 70, 68, 79, 77, 78, 81, 80, 82, 83, 84, 85, 86, 87, 88, 90, 89, 91, 92, 93, 94, 95, 97, 96, 102, 98, 101, 100, 99, 38, 28, 29, 30, 31, 37, 34, 33, 36, 35, 32, 27, 24, 25, 23, 26, 22, 21, 20, 7, 8, 11, 12, 50, 13, 15, 14, 17, 6, 40, 41, 42, 43, 45, 46, 48, 47, 49, 52, 51, 53, 3, 54, 2, 1]


optimal_start_time1, waiting1, violation1, arrival1, early_violations1, late_violations1 = LP(n02, route1, t02, h02, ei02, li02)
optimal_start_time2, waiting2, violation2, arrival2, early_violations2, late_violations2 = LP(n02, route2, t02, h02, ei02, li02)

total_distance1 = compute_total_distance(route1, d02)
total_distance2 = compute_total_distance(route2, d02)

total_time1 = compute_total_time(route1, t02, h02)
total_time2 = compute_total_time(route2, t02, h02)

println("Total time before for route 1: ", total_time1)
println("Total distance before for route 1", total_distance1)
println("Optimal Start Time is: ", optimal_start_time1)
println("Waiting Time is: ", waiting1)
println("violation is: ", violation1)
println("early violations are: ", early_violations1)
println("late violations are: ", late_violations1)

println("Total time before for route 2: ", total_time2)
println("Total distance before for route 2: ", total_distance2)
println("Optimal Start Time is: ", optimal_start_time2)
println("Waiting Time is: ", waiting2)
println("violation is: ", violation2)
println("early violations are: ", early_violations2)
println("late violations are: ", late_violations2)
=#
