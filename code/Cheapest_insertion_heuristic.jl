using Random
using Pkg
using CSV
using DataFrames
using Dates
#Pkg.add("StatsBase")
using StatsBase
using Plots
using StatsPlots

include("Data_Read.jl")
include("Compute_arrival_times_weighted_step.jl")

function compute_total_distance(solution::Vector{Int64}, d::Matrix{Int64})
    total_distance = 0
    for i in 2:(length(solution))
        total_distance += d[solution[i-1], solution[i]]
    end
    return total_distance
end

function compute_total_time(solution::Vector{Int64}, t::Matrix{Int64}, h::Vector{Int64})
    total_time = 0
    for i in 2:(length(solution))
        total_time += t[solution[i-1], solution[i]] + h[solution[i]]
    end
    return total_time
end

function Cheapest_Insertion_With_Tie_Breaking(n::Int64, d::Matrix{Int64}, t::Matrix{Int64}, h::Vector{Int64}, ei::Vector{Int64}, li::Vector{Int64}, q::Float64)
    # Initialize solution with depot
    solution = [1, 1]  # Start and end at depot
    unvisited_nodes = collect(2:n)  # All nodes except the depot

    while !isempty(unvisited_nodes)
        best_nodes = []  # Track nodes with the minimum cost
        best_positions = []
        min_total_cost = Inf

        # Evaluate each unvisited node
        for node in unvisited_nodes
            for i in 2:length(solution)
                # Try inserting the node at position i
                temp_solution = deepcopy(solution)
                insert!(temp_solution, i, node)

                # Compute the cost of this insertion
                _, _, _, _, _, _, _, _, _, _, _, temp_violationsLate, _ = compute_arrival_times_weighted_step(temp_solution, t, h, ei, li)
                total_distance = compute_total_distance(temp_solution, d)
                total_time = compute_total_time(temp_solution, t, h)
                total_cost = 0.4 * q * total_distance + 0.4 * total_time + 0.2 * temp_violationsLate

                # Check for a new best cost or tie
                if total_cost < min_total_cost
                    # Found a better insertion
                    min_total_cost = total_cost
                    best_nodes = [node]
                    best_positions = [i]
                elseif total_cost == min_total_cost
                    # Tie: Add this node and position to the lists
                    push!(best_nodes, node)
                    push!(best_positions, i)
                end
            end
        end

        # Tie-breaking rule: Select the node with the smallest index
        sorted_indices = sortperm(best_nodes)  # Sort nodes by their indices
        selected_index = sorted_indices[1]  # Pick the first node in sorted order

        best_node = best_nodes[selected_index]
        best_position = best_positions[selected_index]

        # Insert the best node into the solution
        insert!(solution, best_position, best_node)

        # Remove the inserted node from the unvisited list
        unvisited_nodes = filter(x -> x != best_node, unvisited_nodes)
    end

    # Compute final metrics for the solution
    arrival_times, waiting_nodes, waiting_times, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(solution, t, h, ei, li)
    return solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time
end

#=
total_distance = compute_total_distance(solution, d02)
total_time = compute_total_time(solution, t02, h02)
obj = 0.4 * total_distance + 0.4 * total_time + 0.2 * violationsLate 

solution_1, early_violations_1, early_violations_duration_1, early_violation_node_indices_1, late_violations_1, late_violations_duration_1, late_violation_node_indices_1, violations_1, violationsEarly_1, violationsLate_1, total_waiting_time_1 = Cheapest_Insertion_With_Tie_Breaking(n02, d02, t02, h02, ei02, li02, q02)
println("Solution 1: ", solution_1, " objective: ", obj, " total distance: ", total_distance, " total time: ", total_time, " Early Violations: ", early_violations_1, ", Late Violations: ", late_violations_1, ", Total Violations: ", violations_1, ", Total Waiting Time: ", total_waiting_time_1)
=#