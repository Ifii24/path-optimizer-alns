struct BestCosts3
    best_cost::Float64
    second_best_cost::Float64
    third_best_cost::Float64 
    best_position::Int
end


function Regret_Insertion_k3(
    solution::Vector{Int64},         # Current partial solution (route)
    removed_nodes::Vector{Int64},    # List of nodes to be reinserted
    d::Matrix{Int64},                # Distance 
    t::Matrix{Int64},                # Time 
    h::Vector{Int64},                # Handling times 
    ei::Vector{Int64},               # TW Start 
    li::Vector{Int64},               # TW End 
    q::Float64                       # distance normalisation factor
)
    new_solution = deepcopy(solution)

    # While there are still nodes left to insert
    while !isempty(removed_nodes)

        best_costs = Vector{BestCosts3}(undef, length(removed_nodes))  # undefined vector to store BestCosts3 structs

        for (idx, node) in enumerate(removed_nodes)   # if:   removed_nodes = [73, 47, 21, 42]
                                                        # then:   enumerate(removed_nodes) = (1, 73), (2, 47), (3, 21), (4, 42)

            cost_positions = []

            for i in 2:length(new_solution)
                temp_solution = deepcopy(new_solution)
                insert!(temp_solution, i, node)

                temp_arrival_times, temp_waiting_times, temp_waiting_nodes, temp_early_violations, temp_early_violation_node_indices, temp_early_violations_duration, temp_late_violations, temp_late_violation_node_indices, temp_late_violations_duration, temp_violations, temp_violationsEarly, temp_violationsLate, temp_total_waiting_time = compute_arrival_times_weighted_step(temp_solution, t, h, ei, li)

                #additional_distance = compute_additional_distance(new_solution, temp_solution, d)
                #additional_time = compute_additional_time(new_solution, temp_solution, t, h)
                #total_cost = 0.3 * q * additional_distance + 0.3 * additional_time + 0.2 * temp_violationsLate + 0.2 * temp_total_waiting_time

                total_distance = compute_total_distance(temp_solution, d)
                total_time = compute_total_time(temp_solution, t, h)
                total_cost = 0.4 * q * total_distance + 0.4 * total_time + 0.2 * temp_violationsLate 

                push!(cost_positions, (total_cost, i))
            end

            sorted_costs = sort(cost_positions, by = x -> x[1]) # sort in ascending order --> best cost = min cost

                                                        # if sorted_costs = [(5.0, 4), (10.0, 17), (20.0, 9), (35.0, 6), ...]
            best_cost, best_position = sorted_costs[1]  # best_cost = sorted_costs[1][1] = 5.0
            second_best_cost = sorted_costs[2][1]       # second_best_cost = sorted_costs[2][1] = 10.0
            third_best_cost = sorted_costs[3][1]        # third_best_cost = sorted_costs[3][1] = 20.0

            # store the best, second-best and third-best costs **for the current node**
            best_costs[idx] = BestCosts3(best_cost, second_best_cost, third_best_cost, best_position) # best_costs = [BestCosts3(10.0, 20.0, 27.0, 3), BestCosts3(15.0, 28.0, 45.0, 4), ...]
                                                                                                     #                    for node 73 at idx=1 ,          for node 47 at idx=2 , ...
                                                                                                     # idx = 1 --> (1, 73)
        end

        # below we calculate the regret costs and choose the best node to insert
        max_regret = -Inf
        best_node = -1
        best_position = -1

        for (idx, node) in enumerate(removed_nodes)
            costs = best_costs[idx]         # costs: an instance of the BestCosts3 struct 
                                            # costs = best_costs[idx=1] = BestCosts3(10.0, 20.0, 27.0, 3)
                                            # costs.best_cost = 10.0
                                            # costs.second_best_cost = 20.0
                                            # costs.third_best_cost = 27.0
            regret_cost = (costs.second_best_cost - costs.best_cost) + (costs.third_best_cost - costs.best_cost)  # regret_3 = (c2-c1) + (c3-c1)

            if regret_cost > max_regret
                max_regret = regret_cost
                best_node = node
                best_position = costs.best_position
                #println("CURRENTLY Max regret-3 cost is: ", max_regret, " for node: ", best_node, " and position: ", best_position)
            end
        end # now that this loop is over we have the highest regret cost and therefore the node and position in the route to reinsert it

        # we reinsert
        insert!(new_solution, best_position, best_node)

        # and finally we remove the node from removed_nodes
        index = findfirst(x -> x == best_node, removed_nodes)
        deleteat!(removed_nodes, index)

        #println(" k = 3: We ended up insering node: ", best_node, " at position: ", best_position)
    end # now that this loop is over we have reinserted all the nodes

    arrival_times, waiting_nodes, waiting_times, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(new_solution, t, h, ei, li)

    return new_solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time
end

#=
route = [1, 77, 79, 68, 69, 70, 81, 80, 82, 83, 84, 85, 86, 87, 88, 90, 89, 92, 93, 94, 95, 97, 96, 102, 98, 99, 100, 101, 38, 28, 30, 31, 32, 37, 33, 34, 35, 36, 27, 39, 20, 23, 26, 22, 1]
removed_nodes = [73, 47, 21, 42, 55, 3, 59, 64, 25, 24, 29, 57, 65, 61, 71, 72, 66, 67, 91, 44, 56, 62, 60, 76, 75, 74, 63, 18, 78, 19, 13, 15, 14, 7, 8, 9, 10, 11, 12, 40, 41, 43, 45, 46, 48, 49, 53, 54, 4, 5, 58, 16, 17, 6, 50, 51, 52, 2]
new_solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time = Regret_Insertion_k3(route, removed_nodes, d, t, h, ei, li, q)
=#