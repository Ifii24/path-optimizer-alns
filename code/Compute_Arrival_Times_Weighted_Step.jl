function compute_arrival_times_weighted_step(solution::Vector{Int64}, t::Matrix{Int64}, h::Vector{Int64}, ei::Vector{Int64}, li::Vector{Int64})

    # Thresholds and penalties for waiting, early violations, and late violations
    waiting_thresholds = [15, 30, 60]  # minutes
    waiting_penalties = [0.1, 0.5, 1.0]

    violation_thresholds = [5, 15, 30]  # minutes
    violation_penalties = [0.5, 2.0, 4.0]

    arrival_times = [(ei[solution[2]] - t[solution[1], solution[2]]) >= 0 ? (ei[solution[2]] - t[solution[1], solution[2]]) : 0]

    # Tracking results
    waiting_times, wait_nodes = [], []
    early_violations, early_violation_node_indices, early_violations_duration = [], [], []
    late_violations, late_violation_node_indices, late_violations_duration = [], [], []
    violations, violationsEarly, violationsLate, total_waiting_time = 0, 0, 0, 0
    total_cost = 0.0  # Total cost of the route (waiting + violations)

    for i in 2:length(solution)

        from_node, to_node = solution[i-1], solution[i]
        travel_time = t[from_node, to_node]
        handling_time = h[to_node]
        arrival_time = arrival_times[end] + travel_time    

        #println("From node : ", from_node, " to node: ", to_node, " travel time is: ", travel_time, " and arrival time is: ", arrival_time, " and handling time is: ", handling_time)

        # Handling early arrivals (choose between waiting and early violation)
        if arrival_time < ei[to_node]

            # Calculate penalties
            waiting_time = ei[to_node] - arrival_time
            waiting_cost = step_penalty(waiting_time, waiting_thresholds, waiting_penalties)

            early_violation = ei[to_node] - arrival_time
            early_violation_cost = step_penalty(early_violation, violation_thresholds, violation_penalties)

            # Compare costs
            if waiting_cost <= early_violation_cost

                # Prefer WAITING
                arrival_time += waiting_time
                total_waiting_time += waiting_time
                total_cost += waiting_cost
                push!(waiting_times, waiting_time)
                push!(wait_nodes, to_node)

                #println("Prefer Waiting and Arrival time is: ", arrival_time)
            else

                # Prefer EARLY VIOLATION
                push!(early_violations, to_node)
                push!(early_violation_node_indices, i)
                push!(early_violations_duration, early_violation)
                violationsEarly += early_violation
                violations += early_violation
                total_cost += early_violation_cost

            end
        end

        # Handling late arrivals
        if arrival_time > li[to_node]
            late_violation = arrival_time - li[to_node]
            late_violation_cost = step_penalty(late_violation, violation_thresholds, violation_penalties)
            
            push!(late_violations, to_node)
            push!(late_violation_node_indices, i)
            push!(late_violations_duration, late_violation)
            violationsLate += late_violation
            violations += late_violation
            total_cost += late_violation_cost
        end

        # Add handling time and update arrival times
        arrival_time += handling_time
        push!(arrival_times, arrival_time)

        #println("we either prefer early violation or late violation and the arrival time is : ", arrival_time)
    end

    return arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time, total_cost
end

# Step penalty function (unchanged)
function step_penalty(violation::Int, thresholds::Vector{Int}, penalties::Vector{Float64})
    for i in 1:length(thresholds)
        if violation <= thresholds[i]
            return penalties[i]
        end
    end
    return penalties[end]
end
