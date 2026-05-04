"""
Input: 
- n: Int - number of nodes (Including Depot = node #1)
- d: distance matrix (n x n)
- t: time matrix  (n x n)
- h: handling times (array of n)
- e: Time Window Opens (array of n)
- l: Time Window Closes (array of n)

Functinality:
It performs the NN greedy heuristic (It selects the nearest unvisited node based on distance d from the current node). It keeps track of the TW violations but doesn't take into consideration the TWs when building the greedy route
It considers handling time.

Output:
- visited_nodes: list of n+1 (Since it returns to the Depot). It only adds the 1 after the while loop so it doesn't interfere with the route in ways that it shouldn't
- early_violations: A list of nodes where the vehicle arrived earlier than the earliest allowed time window.
- late_violations: A list of nodes where the vehicle arrived later than the latest allowed time window.
- total_distance: The total distance traveled on the route (including the distsnce of the route back to the Depot).
- final_time: The final time at which the vehicle returns to the depot (including the time of the route back to the Depot). It includes both the time it takes to travel from node to node as well as the handling time.

"""
# Greedy distance-based algorithm considering handling time
function greedy_distance(n, d, t, e, l, h)
    current_node = 1  # Start at the depot (node 0)
    visited_nodes = [current_node]  # List to track the visited nodes
    current_time = e[1]  # Start at the earliest time for the depot (node 0)
    total_distance = 0  # Track total traveled distance
    early_violations = []  # Track nodes that violate by arriving too early
    early_violations_duration = [] # time violation at the corresponding nodes where early violations occured
    late_violations = []   # Track nodes that violate by arriving too late
    late_violations_duration = []  # time violation at the corresponding nodes where late violations occured
    
    
    while length(visited_nodes) < n
        # Find the nearest unvisited node
        next_node, min_distance = -1, Inf
        for j in 2:n
            if j ∉ visited_nodes && d[current_node, j] < min_distance
                next_node, min_distance = j, d[current_node, j]
            end
        end

        # Update the total traveled distance
        total_distance += d[current_node, next_node]

        # Update the current time (add travel time to next node)
        current_time += t[current_node, next_node]

        # Check for time window violations (before handling time is added)
        if current_time < e[next_node]
            push!(early_violations, next_node)  # Too early
            violation = e[next_node] - current_time  
            push!(early_violations_duration, violation)
        elseif current_time > l[next_node]
            push!(late_violations, next_node)   # Too late
            violation = current_time - l[next_node]  
            push!(late_violations_duration, violation)
        end

        # After checking for time window violations, add the handling time at the node
        current_time += h[next_node]

        # Visit the next node
        push!(visited_nodes, next_node)
        current_node = next_node  # Move to the next node
    end

    # Return to the depot (Node 1)
    total_distance += d[current_node, 1]  # Add the distance back to the depot
    current_time += t[current_node, 1]    # Add the travel time back to the depot
    push!(visited_nodes, 1)  # Explicitly add the depot to the visited nodes

    early_violations = convert(Vector{Int64}, early_violations)
    early_violations_duration = convert(Vector{Int64}, early_violations_duration)
    late_violations = convert(Vector{Int64}, late_violations)
    late_violations_duration = convert(Vector{Int64}, late_violations_duration)

    return visited_nodes, early_violations, early_violations_duration, late_violations, late_violations_duration, total_distance, current_time
end



#=
function time_to_seconds(time::Time)
    return hour(time) * 3600 + minute(time) * 60 + second(time)
end
# Convert time windows to seconds
ei02 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders02)])
li02 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders02)])
n02 = 102
h02 = vcat(0, orders02[!, "Handling Time (s)"])
d02 = zeros(Int, n02, n02)
for row in eachrow(distances02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer
    
    # Populate the matrix with integer values
    d02[from_node, to_node] = distance
end
t02 = zeros(Int, n02, n02)
for row in eachrow(distances02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer
    
    # Populate the matrix with integer values
    t02[from_node, to_node] = time
end

# Run the greedy distance-based solution
visited, early_violations, early_violations_duration, late_violations, late_violations_duration, total_distance, final_time = greedy_distance(n02, d02, t02, ei02, li02, h02)

println("Greedy distance-based solution: $visited")
println("Nodes with early time window violations: $early_violations")
println("Violations on these nodes (early): $early_violations_duration")
println("Nodes with late time window violations: $late_violations")
println("Violations on these nodes (late): $late_violations_duration")
println("Total traveled distance: $total_distance")
println("Final time upon returning to the depot: $final_time")
=#



