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
include("Compute_Arrival_Times_Weighted_Step.jl")
include("NN_based_greedy_algorithm.jl")
include("LP.jl")



datasets = Dict(
    "01large" => Dict("n" => n01large, "d" => d01large, "t" => t01large, "ei" => ei01large, "li" => li01large, "q" => q01large, "h" => h01large),
    "01A" => Dict("n" => n01A, "d" => d01A, "t" => t01A, "ei" => ei01A, "li" => li01A, "q" => q01A, "h" => h01A),
    "01B" => Dict("n" => n01B, "d" => d01B, "t" => t01B, "ei" => ei01B, "li" => li01B, "q" => q01B, "h" => h01B),
    "01C" => Dict("n" => n01C, "d" => d01C, "t" => t01C, "ei" => ei01C, "li" => li01C, "q" => q01C, "h" => h01C),
    "01D" => Dict("n" => n01D, "d" => d01D, "t" => t01D, "ei" => ei01D, "li" => li01D, "q" => q01D, "h" => h01D),
    "02" => Dict("n" => n02, "d" => d02, "t" => t02, "ei" => ei02, "li" => li02, "q" => q02, "h" => h02),
    "03" => Dict("n" => n03, "d" => d03, "t" => t03, "ei" => ei03, "li" => li03, "q" => q03, "h" => h03),
    "04A" => Dict("n" => n04A, "d" => d04A, "t" => t04A, "ei" => ei04A, "li" => li04A, "q" => q04A, "h" => h04A),
    "04B" => Dict("n" => n04B, "d" => d04B, "t" => t04B, "ei" => ei04B, "li" => li04B, "q" => q04B, "h" => h04B),
    "05_01" => Dict("n" => n05_01, "d" => d05_01, "t" => t05_01, "ei" => ei05_01, "li" => li05_01, "q" => q05_01, "h" => h05_01),
    "05_02" => Dict("n" => n05_02, "d" => d05_02, "t" => t05_02, "ei" => ei05_02, "li" => li05_02, "q" => q05_02, "h" => h05_02),
    "05_03" => Dict("n" => n05_03, "d" => d05_03, "t" => t05_03, "ei" => ei05_03, "li" => li05_03, "q" => q05_03, "h" => h05_03),
    "05_04" => Dict("n" => n05_04, "d" => d05_04, "t" => t05_04, "ei" => ei05_04, "li" => li05_04, "q" => q05_04, "h" => h05_04),
    "05_05" => Dict("n" => n05_05, "d" => d05_05, "t" => t05_05, "ei" => ei05_05, "li" => li05_05, "q" => q05_05, "h" => h05_05),
    "05_06" => Dict("n" => n05_06, "d" => d05_06, "t" => t05_06, "ei" => ei05_06, "li" => li05_06, "q" => q05_06, "h" => h05_06),
    "05_07" => Dict("n" => n05_07, "d" => d05_07, "t" => t05_07, "ei" => ei05_07, "li" => li05_07, "q" => q05_07, "h" => h05_07),
    "05_08" => Dict("n" => n05_08, "d" => d05_08, "t" => t05_08, "ei" => ei05_08, "li" => li05_08, "q" => q05_08, "h" => h05_08),
    "05_09" => Dict("n" => n05_09, "d" => d05_09, "t" => t05_09, "ei" => ei05_09, "li" => li05_09, "q" => q05_09, "h" => h05_09),
    "05_10" => Dict("n" => n05_10, "d" => d05_10, "t" => t05_10, "ei" => ei05_10, "li" => li05_10, "q" => q05_10, "h" => h05_10),
    "05_11" => Dict("n" => n05_11, "d" => d05_11, "t" => t05_11, "ei" => ei05_11, "li" => li05_11, "q" => q05_11, "h" => h05_11),
    "05_12" => Dict("n" => n05_12, "d" => d05_12, "t" => t05_12, "ei" => ei05_12, "li" => li05_12, "q" => q05_12, "h" => h05_12),
    "05_13" => Dict("n" => n05_13, "d" => d05_13, "t" => t05_13, "ei" => ei05_13, "li" => li05_13, "q" => q05_13, "h" => h05_13),
    "05_14" => Dict("n" => n05_14, "d" => d05_14, "t" => t05_14, "ei" => ei05_14, "li" => li05_14, "q" => q05_14, "h" => h05_14),
    "05_15" => Dict("n" => n05_15, "d" => d05_15, "t" => t05_15, "ei" => ei05_15, "li" => li05_15, "q" => q05_15, "h" => h05_15),
    "05_16" => Dict("n" => n05_16, "d" => d05_16, "t" => t05_16, "ei" => ei05_16, "li" => li05_16, "q" => q05_16, "h" => h05_16),
    "05_17" => Dict("n" => n05_17, "d" => d05_17, "t" => t05_17, "ei" => ei05_17, "li" => li05_17, "q" => q05_17, "h" => h05_17),
    "05_18" => Dict("n" => n05_18, "d" => d05_18, "t" => t05_18, "ei" => ei05_18, "li" => li05_18, "q" => q05_18, "h" => h05_18),
    "06_01" => Dict("n" => n06_01, "d" => d06_01, "t" => t06_01, "ei" => ei06_01, "li" => li06_01, "q" => q06_01, "h" => h06_01),
    "06_02" => Dict("n" => n06_02, "d" => d06_02, "t" => t06_02, "ei" => ei06_02, "li" => li06_02, "q" => q06_02, "h" => h06_02),
    "06_03" => Dict("n" => n06_03, "d" => d06_03, "t" => t06_03, "ei" => ei06_03, "li" => li06_03, "q" => q06_03, "h" => h06_03),
    "06_04" => Dict("n" => n06_04, "d" => d06_04, "t" => t06_04, "ei" => ei06_04, "li" => li06_04, "q" => q06_04, "h" => h06_04),
    "06_05" => Dict("n" => n06_05, "d" => d06_05, "t" => t06_05, "ei" => ei06_05, "li" => li06_05, "q" => q06_05, "h" => h06_05),
    "06_06" => Dict("n" => n06_06, "d" => d06_06, "t" => t06_06, "ei" => ei06_06, "li" => li06_06, "q" => q06_06, "h" => h06_06),
    "06_07" => Dict("n" => n06_07, "d" => d06_07, "t" => t06_07, "ei" => ei06_07, "li" => li06_07, "q" => q06_07, "h" => h06_07),
    "06_08" => Dict("n" => n06_08, "d" => d06_08, "t" => t06_08, "ei" => ei06_08, "li" => li06_08, "q" => q06_08, "h" => h06_08),
    "06_09" => Dict("n" => n06_09, "d" => d06_09, "t" => t06_09, "ei" => ei06_09, "li" => li06_09, "q" => q06_09, "h" => h06_09),
    "06_10" => Dict("n" => n06_10, "d" => d06_10, "t" => t06_10, "ei" => ei06_10, "li" => li06_10, "q" => q06_10, "h" => h06_10),
    "06_11" => Dict("n" => n06_11, "d" => d06_11, "t" => t06_11, "ei" => ei06_11, "li" => li06_11, "q" => q06_11, "h" => h06_11),
    "06_12" => Dict("n" => n06_12, "d" => d06_12, "t" => t06_12, "ei" => ei06_12, "li" => li06_12, "q" => q06_12, "h" => h06_12),
    "06_13" => Dict("n" => n06_13, "d" => d06_13, "t" => t06_13, "ei" => ei06_13, "li" => li06_13, "q" => q06_13, "h" => h06_13),
    "06_14" => Dict("n" => n06_14, "d" => d06_14, "t" => t06_14, "ei" => ei06_14, "li" => li06_14, "q" => q06_14, "h" => h06_14),
    "06_15" => Dict("n" => n06_15, "d" => d06_15, "t" => t06_15, "ei" => ei06_15, "li" => li06_15, "q" => q06_15, "h" => h06_15),
    "06_16" => Dict("n" => n06_16, "d" => d06_16, "t" => t06_16, "ei" => ei06_16, "li" => li06_16, "q" => q06_16, "h" => h06_16),
    "07_01" => Dict("n" => n07_01, "d" => d07_01, "t" => t07_01, "ei" => ei07_01, "li" => li07_01, "q" => q07_01, "h" => h07_01),
    "07_02" => Dict("n" => n07_02, "d" => d07_02, "t" => t07_02, "ei" => ei07_02, "li" => li07_02, "q" => q07_02, "h" => h07_02),
    "07_03" => Dict("n" => n07_03, "d" => d07_03, "t" => t07_03, "ei" => ei07_03, "li" => li07_03, "q" => q07_03, "h" => h07_03),
    "07_03_modified" => Dict("n" => n07_03_modified, "d" => d07_03_modified, "t" => t07_03_modified, "ei" => ei07_03_modified, "li" => li07_03_modified, "q" => q07_03_modified, "h" => h07_03_modified),
    "07_04" => Dict("n" => n07_04, "d" => d07_04, "t" => t07_04, "ei" => ei07_04, "li" => li07_04, "q" => q07_04, "h" => h07_04),
    "07_05" => Dict("n" => n07_05, "d" => d07_05, "t" => t07_05, "ei" => ei07_05, "li" => li07_05, "q" => q07_05, "h" => h07_05),
    "07_06" => Dict("n" => n07_06, "d" => d07_06, "t" => t07_06, "ei" => ei07_06, "li" => li07_06, "q" => q07_06, "h" => h07_06),
    "07_07" => Dict("n" => n07_07, "d" => d07_07, "t" => t07_07, "ei" => ei07_07, "li" => li07_07, "q" => q07_07, "h" => h07_07),
    "07_08" => Dict("n" => n07_08, "d" => d07_08, "t" => t07_08, "ei" => ei07_08, "li" => li07_08, "q" => q07_08, "h" => h07_08),
    "07_09" => Dict("n" => n07_09, "d" => d07_09, "t" => t07_09, "ei" => ei07_09, "li" => li07_09, "q" => q07_09, "h" => h07_09),
    "07_09_modified" => Dict("n" => n07_09_modified, "d" => d07_09_modified, "t" => t07_09_modified, "ei" => ei07_09_modified, "li" => li07_09_modified, "q" => q07_09_modified, "h" => h07_09_modified),
    "07_10" => Dict("n" => n07_10, "d" => d07_10, "t" => t07_10, "ei" => ei07_10, "li" => li07_10, "q" => q07_10, "h" => h07_10),
    "07_11" => Dict("n" => n07_11, "d" => d07_11, "t" => t07_11, "ei" => ei07_11, "li" => li07_11, "q" => q07_11, "h" => h07_11),
    "07_11_modified" => Dict("n" => n07_11_modified, "d" => d07_11_modified, "t" => t07_11_modified, "ei" => ei07_11_modified, "li" => li07_11_modified, "q" => q07_11_modified, "h" => h07_11_modified),
    "07_12" => Dict("n" => n07_12, "d" => d07_12, "t" => t07_12, "ei" => ei07_12, "li" => li07_12, "q" => q07_12, "h" => h07_12),
    "07_12_modified" => Dict("n" => n07_12_modified, "d" => d07_12_modified, "t" => t07_12_modified, "ei" => ei07_12_modified, "li" => li07_12_modified, "q" => q07_12_modified, "h" => h07_12_modified),
    "07_13" => Dict("n" => n07_13, "d" => d07_13, "t" => t07_13, "ei" => ei07_13, "li" => li07_13, "q" => q07_13, "h" => h07_13),
    "07_14" => Dict("n" => n07_14, "d" => d07_14, "t" => t07_14, "ei" => ei07_14, "li" => li07_14, "q" => q07_14, "h" => h07_14),
    "07_15" => Dict("n" => n07_15, "d" => d07_15, "t" => t07_15, "ei" => ei07_15, "li" => li07_15, "q" => q07_15, "h" => h07_15),
    "07_16" => Dict("n" => n07_16, "d" => d07_16, "t" => t07_16, "ei" => ei07_16, "li" => li07_16, "q" => q07_16, "h" => h07_16),
    "07_16_modified" => Dict("n" => n07_16_modified, "d" => d07_16_modified, "t" => t07_16_modified, "ei" => ei07_16_modified, "li" => li07_16_modified, "q" => q07_16_modified, "h" => h07_16_modified),
    "07_17" => Dict("n" => n07_17, "d" => d07_17, "t" => t07_17, "ei" => ei07_17, "li" => li07_17, "q" => q07_17, "h" => h07_17),
    "08_01" => Dict("n" => n08_01, "d" => d08_01, "t" => t08_01, "ei" => ei08_01, "li" => li08_01, "q" => q08_01, "h" => h08_01),
    "08_01_modified" => Dict("n" => n08_01_modified, "d" => d08_01_modified, "t" => t08_01_modified, "ei" => ei08_01_modified, "li" => li08_01_modified, "q" => q08_01_modified, "h" => h08_01_modified),
    "08_02" => Dict("n" => n08_02, "d" => d08_02, "t" => t08_02, "ei" => ei08_02, "li" => li08_02, "q" => q08_02, "h" => h08_02),
    "08_02_modified" => Dict("n" => n08_02_modified, "d" => d08_02_modified, "t" => t08_02_modified, "ei" => ei08_02_modified, "li" => li08_02_modified, "q" => q08_02_modified, "h" => h08_02_modified),
    "08_03" => Dict("n" => n08_03, "d" => d08_03, "t" => t08_03, "ei" => ei08_03, "li" => li08_03, "q" => q08_03, "h" => h08_03),
    "08_04" => Dict("n" => n08_04, "d" => d08_04, "t" => t08_04, "ei" => ei08_04, "li" => li08_04, "q" => q08_04, "h" => h08_04),
    "09" => Dict("n" => n09, "d" => d09, "t" => t09, "ei" => ei09, "li" => li09, "q" => q09, "h" => h09),
    "10" => Dict("n" => n10, "d" => d10, "t" => t10, "ei" => ei10, "li" => li10, "q" => q10, "h" => h10)
)


using CSV
using DataFrames
using XLSX 

# Initialize results storage
results = Dict()

for set_name in keys(datasets)

    current_set = datasets[set_name]

    n, d, t, ei, li, q, h = current_set["n"], current_set["d"], current_set["t"], current_set["ei"], current_set["li"], current_set["q"], current_set["h"]

    println("Processing Set: ", set_name)
    
    visited, early_violations, early_violations_duration, late_violations, late_violations_duration, total_distance, final_time = greedy_distance(n, d, t, ei, li, h)

    # before LP
    arrival_times, waiting_times, wait_nodes, early_violations, early_violation_node_indices, early_violations_duration, late_violations, late_violation_node_indices, late_violations_duration, violations, violationsEarly, violationsLate, total_waiting_time, total_cost = compute_arrival_times_weighted_step(visited, t, h, ei, li)
    
    # after LP
    _, total_waiting_time, total_violations, _, _, early_violations, late_violations = LP(n, visited, t, h, ei, li)
    
    total_distance = compute_total_distance(visited, d)
    total_time = compute_total_time(visited, t, h)
    best_cost = 0.4 * q * total_distance + 0.4 * total_time + 0.2 * sum(late_violations)
    
    println("best cost is: ", best_cost)
    println("total travel time is: ", total_time)
    println("total distance is: ", total_distance)
    println("total waiting time is: ", total_waiting_time)
    println("total early violation is: ", sum(early_violations))
    println("total late violation is: ", sum(late_violations))

    results[set_name] = [best_cost, total_time, total_distance, total_waiting_time, sum(early_violations), sum(late_violations)]

end

df = DataFrame(reduce(hcat, collect(values(results)))', [:cost, :t, :d, :wt, :ev, :lv])
# Add dataset names as the first column
insertcols!(df, 1, :Dataset => collect(keys(results)))  

# Save as CSV
CSV.write("init.csv", df)

# Save as XLSX (Excel file)
XLSX.writetable("init.xlsx", df)

println("Saved results to results.csv and results.xlsx")
