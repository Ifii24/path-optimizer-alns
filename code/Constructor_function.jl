"""
!!!For each node we choose the best position to insert it, we insert it and then we proceed to the next node. We do NOT check for all nodes at the same time!!!

Input: 
- solution: the remaining solution (route) as an array of integers (actual nodes) --> size = (n+1) since the solution starts and ends with the Depot
- removed_nodes: the array of removed nodes to be reinserted into the solution
- n: Int - number of nodes (including the depot, which is node #1)
- d: distance matrix (n x n)
- t: time matrix (n x n)
- h: array of handling times (size n)
- ei: array of earliest time windows (size n)
- li: array of latest time windows (size n)

Functionality: 
- Reinsert the removed nodes into the route at the best possible position to minimize the total distance (???). The function also checks for time window violations (early and late) and keeps track of them.
- It evaluates different insertion points for each removed node and chooses the one with the smallest increase in distance.

Output: 
- new_solution: The new constructed solution (array) after reinserting the nodes
- early_violations: An array of nodes that have early arrival violations
- late_violations: An array of nodes that have late arrival violations
- violations: An array of violations in total (either early or late)
"""
function construct(solution::Vector{Int64}, removed_nodes::Vector{Int64}, n::Int64, d::Matrix{Int64}, t::Matrix{Int64}, h::Vector{Int64}, ei::Vector{Int64}, li::Vector{Int64}, q::Float64)
    
    new_solution = deepcopy(solution)  # The partial (remaining) solution
    dynamic_removed_nodes = deepcopy(removed_nodes)  # Nodes to be reinserted
    
    arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time = compute_arrival_times_weighted_step(new_solution, t, h, ei, li)

    best_arrival_times, best_waiting_times, best_waiting_nodes = [], [], []
    best_early_violations, best_early_violations_node_indices, best_early_violations_duration = [], [], []
    best_late_violations, best_late_violations_node_indices, best_late_violations_duration = [], [], []
    best_violations, best_violationsEarly, best_violationsLate, best_total_waiting_time = 0, 0, 0, 0


    while !isempty(dynamic_removed_nodes)

        node = popfirst!(dynamic_removed_nodes)  # Node to insert

        min_total_cost = Inf
        best_position = 2  # Start after the depot

        best_arrival_times, best_waiting_times, best_waiting_nodes = [], [], []
        best_early_violations, best_early_violations_node_indices, best_early_violations_duration = [], [], []
        best_late_violations, best_late_violations_node_indices, best_late_violations_duration = [], [], []
        best_violations, best_violationsEarly, best_violationsLate, best_total_waiting_time = 0, 0, 0, 0

        # Try inserting the node (chosen above) at every possible position i, except replacing the depot at start or end, 
        # then choose the best position to insert that node, 
        # continue with the next node until the While loop is done
        for i in 2:length(new_solution)
            
            temp_solution = deepcopy(new_solution)
            insert!(temp_solution, i, node)
            
            # Compute arrival times and violations for this potential solution
            # Note: Arrival times is actually the arrival time at each node + the handling time at the node
            temp_arrival_times, temp_waiting_times, temp_waiting_nodes, temp_early_violations, temp_early_violation_node_indices, temp_early_violations_duration, temp_late_violations, temp_late_violation_node_indices, temp_late_violations_duration, temp_violations, temp_violationsEarly, temp_violationsLate, temp_total_waiting_time = compute_arrival_times_weighted_step(temp_solution, t, h, ei, li)

            # Calculate the additional cost (distance and time)
            # - new_solution is the solution before inserting the node in question
            # - temp_solution is the solution after the insertion
            additional_distance = compute_additional_distance(new_solution, temp_solution, d) 
            additional_time = compute_additional_time(new_solution, temp_solution, t, h)
    
            #------------------------------------ Here play with the weights---------------------------------------------

            total_cost = 0.4*q*additional_distance + 0.4*additional_time + 0.2*temp_violationsLate # + 0.02*temp_total_waiting_time + 0.03*temp_violationsEarly    # Violations are handled here

            #------------------------------------------------------------------------------------------------------------

            if total_cost < min_total_cost
                min_total_cost = total_cost
                best_position = i 
                best_arrival_times = temp_arrival_times 
                best_waiting_times = temp_waiting_times 
                best_waiting_nodes = temp_waiting_nodes
                best_early_violations = temp_early_violations
                best_early_violations_node_indices = temp_early_violation_node_indices 
                best_early_violations_duration = temp_early_violations_duration 
                best_late_violations = temp_late_violations
                best_late_violations_node_indices = temp_late_violation_node_indices 
                best_late_violations_duration = temp_late_violations_duration 
                best_violations = temp_violations
                best_violationsEarly = temp_violationsEarly 
                best_violationsLate = temp_violationsLate
                best_total_waiting_time = temp_total_waiting_time 
            end
        end
        
        # Insert the node at the best position - new_solution gets updated here
        insert!(new_solution, best_position, node)

    end

    arrival_times = best_arrival_times  # Update arrival times with the best ones (still including handling times)
    waiting_nodes = best_waiting_nodes
    early_violations = best_early_violations
    early_violation_node_indices = best_early_violations_node_indices
    early_violations_duration = best_early_violations_duration
    violationsEarly = best_violationsEarly
    late_violations = best_late_violations
    late_violation_node_indices = best_late_violations_node_indices
    late_violations_duration = best_late_violations_duration
    violationsLate = best_violationsLate
    violations = best_violations
    waiting_times = best_waiting_times
    total_waiting_time = best_total_waiting_time

    early_violations_duration = convert(Vector{Int64}, early_violations_duration)
    late_violations_duration = convert(Vector{Int64}, late_violations_duration)

    return new_solution, early_violations, early_violations_duration, early_violation_node_indices, late_violations, late_violations_duration, late_violation_node_indices, violations, violationsEarly, violationsLate, total_waiting_time

end
