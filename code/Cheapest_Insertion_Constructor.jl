"""
In each iteration we check for each node in the unvisited set of nodes the cost of inserting it in every possible position. 
After checking for all nodes and all positions we insert the node and we remove it from the list of unvisited nodes.
"""
function Cheapest_Insertion_Constructor(solution::Vector{Int64}, removed_nodes::Vector{Int64}, n::Int64, d::Matrix{Int64}, t::Matrix{Int64}, h::Vector{Int64}, ei::Vector{Int64}, li::Vector{Int64}, q::Float64)
    new_solution = deepcopy(solution)  # The partial (remaining) solution
    dynamic_removed_nodes = deepcopy(removed_nodes)  # Nodes to be reinserted

    iter = 0
    while !isempty(dynamic_removed_nodes)
        best_node = -1  
        best_position = -1  
        min_total_cost = Inf 
        iter += 1

        # go through all unvisited nodes
        for node in dynamic_removed_nodes   # node is the actual node and not the idx of the node

            # check the cost of inserting the current node in every possible position
            for i in 2:length(new_solution)
                temp_solution = deepcopy(new_solution)
                insert!(temp_solution, i, node)

                #temp_arrival_times, temp_waiting_times, temp_waiting_nodes, temp_early_violations, temp_early_violation_node_indices, temp_early_violations_duration, temp_late_violations, temp_late_violation_node_indices, temp_late_violations_duration, temp_violations, temp_violationsEarly, temp_violationsLate, temp_total_waiting_time = compute_arrival_times_weighted_step(temp_solution, t, h, ei, li)
                _, _, _, _, _, _, _, _, _, _, _, temp_violationsLate, _ = compute_arrival_times_weighted_step(temp_solution, t, h, ei, li)

                # Calculate the additional cost (distance and time)
               
                total_distance = compute_total_distance(temp_solution, d)
                total_time = compute_total_time(temp_solution, t, h)
                total_cost = 0.4 * q * total_distance + 0.4 * total_time + 0.2 * temp_violationsLate # + 0.005 * temp_total_waiting_time

                # Update the best node and position if this insertion is better
                if total_cost < min_total_cost
                    min_total_cost = total_cost
                    best_node = node
                    best_position = i
                end
            end # after this loop is done we have checked for one particular node  
        end # after this loop is done we have checked for all nodes whats the cheapest to insert

        #println("On iteration: ", iter, " out of all nodes we chose node: ", best_node, " to insert at position: ", best_position)

        # we reinsert
        insert!(new_solution, best_position, best_node)

        # and finally we remove the node from removed_nodes
        index = findfirst(x -> x == best_node, dynamic_removed_nodes)
        deleteat!(dynamic_removed_nodes, index)
    end

    # Compute final arrival times and violations
    arrival_times, waiting_nodes, waiting_times, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(new_solution, t, h, ei, li)

    # Return the new solution and all relevant metrics
    early_violations_duration = convert(Vector{Int64}, early_violations_duration)
    late_violations_duration = convert(Vector{Int64}, late_violations_duration)

    return new_solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time
end


#=
route = [1, 77, 79, 68, 69, 70, 81, 80, 82, 83, 84, 85, 86, 87, 88, 90, 89, 92, 93, 94, 95, 97, 96, 102, 98, 99, 100, 101, 38, 28, 30, 31, 32, 37, 33, 34, 35, 36, 27, 39, 20, 23, 26, 22, 1]
removed_nodes = [73, 47, 21, 42, 55, 3, 59, 64, 25, 24, 29, 57, 65, 61, 71, 72, 66, 67, 91, 44, 56, 62, 60, 76, 75, 74, 63, 18, 78, 19, 13, 15, 14, 7, 8, 9, 10, 11, 12, 40, 41, 43, 45, 46, 48, 49, 53, 54, 4, 5, 58, 16, 17, 6, 50, 51, 52, 2]
new_solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time = Cheapest_Insertion_Constructor(route, removed_nodes, n, d, t, h, ei, li, q)

total_distance = compute_total_distance(new_solution, d)
println("The new solution is: ", new_solution)
println("The early violations are: ", early_violations)
println("The duration of early violations are: ", early_violations_duration)
println("The early violation node indices are: ", early_violation_node_indices)
println("The late violations are: ", late_violations)
println("The duration of late violations are: ", late_violations_duration)
println("The late violation node indices are: ", late_violation_node_indices)
println("The total violations are: ", violations)
println("The violationsEarly are: ", violationsEarly)
println("The violationsLate are: ", violationsLate)
println("The total waiting time is: ", total_waiting_time)
println("The total distance is: ", total_distance)
=#
