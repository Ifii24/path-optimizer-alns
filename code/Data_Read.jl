# Load your actual data
using Pkg
using CSV
using DataFrames
using Dates
using Random

distances01large = CSV.read("Distances01Large.csv", DataFrame; delim=',')
orders01large = CSV.read("Orders01Large.csv", DataFrame)
VehiclesandTerminals01large = CSV.read("VehiclesandTerminals01Large.csv", DataFrame; delim=',')

distances01A = CSV.read("Distances01A.csv", DataFrame; delim=';')
orders01A = CSV.read("Orders01A.csv", DataFrame)
VehiclesandTerminals01A = CSV.read("VehiclesandTerminals01A.csv", DataFrame; delim=';')

distances01B = CSV.read("Distances01B.csv", DataFrame; delim=';')
orders01B = CSV.read("Orders01B.csv", DataFrame)
VehiclesandTerminals01B = CSV.read("VehiclesandTerminals01B.csv", DataFrame; delim=';')

distances01C = CSV.read("Distances01C.csv", DataFrame; delim=';')
orders01C = CSV.read("Orders01C.csv", DataFrame)
VehiclesandTerminals01C = CSV.read("VehiclesandTerminals01C.csv", DataFrame; delim=';')

distances01D = CSV.read("Distances01D.csv", DataFrame; delim=';')
orders01D = CSV.read("Orders01D.csv", DataFrame)
VehiclesandTerminals01D = CSV.read("VehiclesandTerminals01D.csv", DataFrame; delim=';')

distances02 = CSV.read("Distances02.csv", DataFrame; delim=';')
orders02 = CSV.read("Orders02.csv", DataFrame)
VehiclesandTerminals02 = CSV.read("VehiclesandTerminals02.csv", DataFrame; delim=';')

distances03 = CSV.read("Distances03.csv", DataFrame; delim=',')
orders03 = CSV.read("Orders03.csv", DataFrame)
VehiclesandTerminals03 = CSV.read("VehiclesandTerminals03.csv", DataFrame; delim=',')

distances04A = CSV.read("Distances04A.csv", DataFrame; delim=';')
orders04A = CSV.read("Orders04A.csv", DataFrame)
VehiclesandTerminals04A = CSV.read("VehiclesandTerminals04A.csv", DataFrame; delim=';')

distances04B = CSV.read("Distances04B.csv", DataFrame; delim=';')
orders04B = CSV.read("Orders04B.csv", DataFrame)
VehiclesandTerminals04B = CSV.read("VehiclesandTerminals04B.csv", DataFrame; delim=';')

distances05_01 = CSV.read("Distances05_01.csv", DataFrame; delim=';')
orders05_01 = CSV.read("Orders05_01.csv", DataFrame)
VehiclesandTerminals05_01 = CSV.read("VehiclesandTerminals05_01.csv", DataFrame; delim=';')

distances05_02 = CSV.read("Distances05_02.csv", DataFrame; delim=';')
orders05_02 = CSV.read("Orders05_02.csv", DataFrame)
VehiclesandTerminals05_02 = CSV.read("VehiclesandTerminals05_02.csv", DataFrame; delim=';')

distances05_03 = CSV.read("Distances05_03.csv", DataFrame; delim=';')
orders05_03 = CSV.read("Orders05_03.csv", DataFrame)
VehiclesandTerminals05_03 = CSV.read("VehiclesandTerminals05_03.csv", DataFrame; delim=';')

distances05_04 = CSV.read("Distances05_04.csv", DataFrame; delim=';')
orders05_04 = CSV.read("Orders05_04.csv", DataFrame)
VehiclesandTerminals05_04 = CSV.read("VehiclesandTerminals05_04.csv", DataFrame; delim=';')

distances05_05 = CSV.read("Distances05_05.csv", DataFrame; delim=';')
orders05_05 = CSV.read("Orders05_05.csv", DataFrame)
VehiclesandTerminals05_05 = CSV.read("VehiclesandTerminals05_05.csv", DataFrame; delim=';')

distances05_06 = CSV.read("Distances05_06.csv", DataFrame; delim=';')
orders05_06 = CSV.read("Orders05_06.csv", DataFrame)
VehiclesandTerminals05_06 = CSV.read("VehiclesandTerminals05_06.csv", DataFrame; delim=';')

distances05_07 = CSV.read("Distances05_07.csv", DataFrame; delim=';')
orders05_07 = CSV.read("Orders05_07.csv", DataFrame)
VehiclesandTerminals05_07 = CSV.read("VehiclesandTerminals05_07.csv", DataFrame; delim=';')

distances05_08 = CSV.read("Distances05_08.csv", DataFrame; delim=';')
orders05_08 = CSV.read("Orders05_08.csv", DataFrame)
VehiclesandTerminals05_08 = CSV.read("VehiclesandTerminals05_08.csv", DataFrame; delim=';')

distances05_09 = CSV.read("Distances05_09.csv", DataFrame; delim=';')
orders05_09 = CSV.read("Orders05_09.csv", DataFrame)
VehiclesandTerminals05_09 = CSV.read("VehiclesandTerminals05_09.csv", DataFrame; delim=';')

distances05_10 = CSV.read("Distances05_10.csv", DataFrame; delim=';')
orders05_10 = CSV.read("Orders05_10.csv", DataFrame)
VehiclesandTerminals05_10 = CSV.read("VehiclesandTerminals05_10.csv", DataFrame; delim=';')

distances05_11 = CSV.read("Distances05_11.csv", DataFrame; delim=';')
orders05_11 = CSV.read("Orders05_11.csv", DataFrame)
VehiclesandTerminals05_11 = CSV.read("VehiclesandTerminals05_11.csv", DataFrame; delim=';')

distances05_12 = CSV.read("Distances05_12.csv", DataFrame; delim=';')
orders05_12 = CSV.read("Orders05_12.csv", DataFrame)
VehiclesandTerminals05_12 = CSV.read("VehiclesandTerminals05_12.csv", DataFrame; delim=';')

distances05_13 = CSV.read("Distances05_13.csv", DataFrame; delim=';')
orders05_13 = CSV.read("Orders05_13.csv", DataFrame)
VehiclesandTerminals05_13 = CSV.read("VehiclesandTerminals05_13.csv", DataFrame; delim=';')

distances05_14 = CSV.read("Distances05_14.csv", DataFrame; delim=';')
orders05_14 = CSV.read("Orders05_14.csv", DataFrame)
VehiclesandTerminals05_14 = CSV.read("VehiclesandTerminals05_14.csv", DataFrame; delim=';')

distances05_15 = CSV.read("Distances05_15.csv", DataFrame; delim=';')
orders05_15 = CSV.read("Orders05_15.csv", DataFrame)
VehiclesandTerminals05_15 = CSV.read("VehiclesandTerminals05_15.csv", DataFrame; delim=';')

distances05_16 = CSV.read("Distances05_16.csv", DataFrame; delim=',')
orders05_16 = CSV.read("Orders05_16.csv", DataFrame)
VehiclesandTerminals05_16 = CSV.read("VehiclesandTerminals05_16.csv", DataFrame; delim=',')

distances05_17 = CSV.read("Distances05_17.csv", DataFrame; delim=';')
orders05_17 = CSV.read("Orders05_17.csv", DataFrame)
VehiclesandTerminals05_17 = CSV.read("VehiclesandTerminals05_17.csv", DataFrame; delim=';')

distances05_18 = CSV.read("Distances05_18.csv", DataFrame; delim=';')
orders05_18 = CSV.read("Orders05_18.csv", DataFrame)
VehiclesandTerminals05_18 = CSV.read("VehiclesandTerminals05_18.csv", DataFrame; delim=';')







distances06_01 = CSV.read("Distances06_01.csv", DataFrame; delim=';')
orders06_01 = CSV.read("Orders06_01.csv", DataFrame)
VehiclesandTerminals06_01 = CSV.read("VehiclesandTerminals06_01.csv", DataFrame; delim=';')

distances06_02 = CSV.read("Distances06_02.csv", DataFrame; delim=';')
orders06_02 = CSV.read("Orders06_02.csv", DataFrame)
VehiclesandTerminals06_02 = CSV.read("VehiclesandTerminals06_02.csv", DataFrame; delim=';')

distances06_03 = CSV.read("Distances06_03.csv", DataFrame; delim=';')
orders06_03 = CSV.read("Orders06_03.csv", DataFrame)
VehiclesandTerminals06_03 = CSV.read("VehiclesandTerminals06_03.csv", DataFrame; delim=';')

distances06_04 = CSV.read("Distances06_04.csv", DataFrame; delim=';')
orders06_04 = CSV.read("Orders06_04.csv", DataFrame)
VehiclesandTerminals06_04 = CSV.read("VehiclesandTerminals06_04.csv", DataFrame; delim=';')

distances06_05 = CSV.read("Distances06_05.csv", DataFrame; delim=';')
orders06_05 = CSV.read("Orders06_05.csv", DataFrame)
VehiclesandTerminals06_05 = CSV.read("VehiclesandTerminals06_05.csv", DataFrame; delim=';')

distances06_06 = CSV.read("Distances06_06.csv", DataFrame; delim=';')
orders06_06 = CSV.read("Orders06_06.csv", DataFrame)
VehiclesandTerminals06_06 = CSV.read("VehiclesandTerminals06_06.csv", DataFrame; delim=';')

distances06_07 = CSV.read("Distances06_07.csv", DataFrame; delim=';')
orders06_07 = CSV.read("Orders06_07.csv", DataFrame)
VehiclesandTerminals06_07 = CSV.read("VehiclesandTerminals06_07.csv", DataFrame; delim=';')

distances06_08 = CSV.read("Distances06_08.csv", DataFrame; delim=';')
orders06_08 = CSV.read("Orders06_08.csv", DataFrame)
VehiclesandTerminals06_08 = CSV.read("VehiclesandTerminals06_08.csv", DataFrame; delim=';')

distances06_09 = CSV.read("Distances06_09.csv", DataFrame; delim=';')
orders06_09 = CSV.read("Orders06_09.csv", DataFrame)
VehiclesandTerminals06_09 = CSV.read("VehiclesandTerminals06_09.csv", DataFrame; delim=';')

distances06_10 = CSV.read("Distances06_10.csv", DataFrame; delim=';')
orders06_10 = CSV.read("Orders06_10.csv", DataFrame)
VehiclesandTerminals06_10 = CSV.read("VehiclesandTerminals06_10.csv", DataFrame; delim=';')

distances06_11 = CSV.read("Distances06_11.csv", DataFrame; delim=';')
orders06_11 = CSV.read("Orders06_11.csv", DataFrame)
VehiclesandTerminals06_11 = CSV.read("VehiclesandTerminals06_11.csv", DataFrame; delim=';')

distances06_12 = CSV.read("Distances06_12.csv", DataFrame; delim=';')
orders06_12 = CSV.read("Orders06_12.csv", DataFrame)
VehiclesandTerminals06_12 = CSV.read("VehiclesandTerminals06_12.csv", DataFrame; delim=';')

distances06_13 = CSV.read("Distances06_13.csv", DataFrame; delim=';')
orders06_13 = CSV.read("Orders06_13.csv", DataFrame)
VehiclesandTerminals06_13 = CSV.read("VehiclesandTerminals06_13.csv", DataFrame; delim=';')

distances06_14 = CSV.read("Distances06_14.csv", DataFrame; delim=';')
orders06_14 = CSV.read("Orders06_14.csv", DataFrame)
VehiclesandTerminals06_14 = CSV.read("VehiclesandTerminals06_14.csv", DataFrame; delim=';')

distances06_15 = CSV.read("Distances06_15.csv", DataFrame; delim=';')
orders06_15 = CSV.read("Orders06_15.csv", DataFrame)
VehiclesandTerminals06_15 = CSV.read("VehiclesandTerminals06_15.csv", DataFrame; delim=';')

distances06_16 = CSV.read("Distances06_16.csv", DataFrame; delim=';')
orders06_16 = CSV.read("Orders06_16.csv", DataFrame)
VehiclesandTerminals06_16 = CSV.read("VehiclesandTerminals06_16.csv", DataFrame; delim=';')





distances07_01 = CSV.read("Distances07_01.csv", DataFrame; delim=';')
orders07_01 = CSV.read("Orders07_01.csv", DataFrame)
VehiclesandTerminals07_01 = CSV.read("VehiclesandTerminals07_01.csv", DataFrame; delim=';')

distances07_02 = CSV.read("Distances07_02.csv", DataFrame; delim=';')
orders07_02 = CSV.read("Orders07_02.csv", DataFrame)
VehiclesandTerminals07_02 = CSV.read("VehiclesandTerminals07_02.csv", DataFrame; delim=';')

distances07_03 = CSV.read("Distances07_03.csv", DataFrame; delim=';')
orders07_03 = CSV.read("Orders07_03.csv", DataFrame)
VehiclesandTerminals07_03 = CSV.read("VehiclesandTerminals07_03.csv", DataFrame; delim=';')

distances07_03_modified = CSV.read("Distances07_03_modified.csv", DataFrame; delim=';')
orders07_03_modified = CSV.read("Orders07_03_modified.csv", DataFrame)
VehiclesandTerminals07_03_modified = CSV.read("VehiclesandTerminals07_03_modified.csv", DataFrame; delim=';')

distances07_04 = CSV.read("Distances07_04.csv", DataFrame; delim=';')
orders07_04 = CSV.read("Orders07_04.csv", DataFrame)
VehiclesandTerminals07_04 = CSV.read("VehiclesandTerminals07_04.csv", DataFrame; delim=';')

distances07_05 = CSV.read("Distances07_05.csv", DataFrame; delim=';')
orders07_05 = CSV.read("Orders07_05.csv", DataFrame)
VehiclesandTerminals07_05 = CSV.read("VehiclesandTerminals07_05.csv", DataFrame; delim=';')

distances07_06 = CSV.read("Distances07_06.csv", DataFrame; delim=';')
orders07_06 = CSV.read("Orders07_06.csv", DataFrame)
VehiclesandTerminals07_06 = CSV.read("VehiclesandTerminals07_06.csv", DataFrame; delim=';')

distances07_07 = CSV.read("Distances07_07.csv", DataFrame; delim=';')
orders07_07 = CSV.read("Orders07_07.csv", DataFrame)
VehiclesandTerminals07_07 = CSV.read("VehiclesandTerminals07_07.csv", DataFrame; delim=';')

distances07_08 = CSV.read("Distances07_08.csv", DataFrame; delim=';')
orders07_08 = CSV.read("Orders07_08.csv", DataFrame)
VehiclesandTerminals07_08 = CSV.read("VehiclesandTerminals07_08.csv", DataFrame; delim=';')

distances07_09 = CSV.read("Distances07_09.csv", DataFrame; delim=';')
orders07_09 = CSV.read("Orders07_09.csv", DataFrame)
VehiclesandTerminals07_09 = CSV.read("VehiclesandTerminals07_09.csv", DataFrame; delim=';')

distances07_09_modified = CSV.read("Distances07_09_modified.csv", DataFrame; delim=';')
orders07_09_modified = CSV.read("Orders07_09_modified.csv", DataFrame)
VehiclesandTerminals07_09_modified = CSV.read("VehiclesandTerminals07_09_modified.csv", DataFrame; delim=';')

distances07_10 = CSV.read("Distances07_10.csv", DataFrame; delim=';')
orders07_10 = CSV.read("Orders07_10.csv", DataFrame)
VehiclesandTerminals07_10 = CSV.read("VehiclesandTerminals07_10.csv", DataFrame; delim=';')

distances07_11 = CSV.read("Distances07_11.csv", DataFrame; delim=';')
orders07_11 = CSV.read("Orders07_11.csv", DataFrame)
VehiclesandTerminals07_11 = CSV.read("VehiclesandTerminals07_11.csv", DataFrame; delim=';')

distances07_11_modified = CSV.read("Distances07_11_modified.csv", DataFrame; delim=';')
orders07_11_modified = CSV.read("Orders07_11_modified.csv", DataFrame)
VehiclesandTerminals07_11_modified = CSV.read("VehiclesandTerminals07_11_modified.csv", DataFrame; delim=';')

distances07_12 = CSV.read("Distances07_12.csv", DataFrame; delim=';')
orders07_12 = CSV.read("Orders07_12.csv", DataFrame)
VehiclesandTerminals07_12 = CSV.read("VehiclesandTerminals07_12.csv", DataFrame; delim=';')

distances07_12_modified = CSV.read("Distances07_12_modified.csv", DataFrame; delim=';')
orders07_12_modified = CSV.read("Orders07_12_modified.csv", DataFrame)
VehiclesandTerminals07_12_modified = CSV.read("VehiclesandTerminals07_12_modified.csv", DataFrame; delim=';')

distances07_13 = CSV.read("Distances07_13.csv", DataFrame; delim=';')
orders07_13 = CSV.read("Orders07_13.csv", DataFrame)
VehiclesandTerminals07_13 = CSV.read("VehiclesandTerminals07_13.csv", DataFrame; delim=';')

distances07_14 = CSV.read("Distances07_14.csv", DataFrame; delim=';')
orders07_14 = CSV.read("Orders07_14.csv", DataFrame)
VehiclesandTerminals07_14 = CSV.read("VehiclesandTerminals07_14.csv", DataFrame; delim=';')

distances07_15 = CSV.read("Distances07_15.csv", DataFrame; delim=';')
orders07_15 = CSV.read("Orders07_15.csv", DataFrame)
VehiclesandTerminals07_15 = CSV.read("VehiclesandTerminals07_15.csv", DataFrame; delim=';')

distances07_16 = CSV.read("Distances07_16.csv", DataFrame; delim=';')
orders07_16 = CSV.read("Orders07_16.csv", DataFrame)
VehiclesandTerminals07_16 = CSV.read("VehiclesandTerminals07_16.csv", DataFrame; delim=';')

distances07_16_modified = CSV.read("Distances07_16_modified.csv", DataFrame; delim=';')
orders07_16_modified = CSV.read("Orders07_16_modified.csv", DataFrame)
VehiclesandTerminals07_16_modified = CSV.read("VehiclesandTerminals07_16_modified.csv", DataFrame; delim=';')

distances07_17 = CSV.read("Distances07_17.csv", DataFrame; delim=';')
orders07_17 = CSV.read("Orders07_17.csv", DataFrame)
VehiclesandTerminals07_17 = CSV.read("VehiclesandTerminals07_17.csv", DataFrame; delim=';')







distances08_01 = CSV.read("Distances08_01.csv", DataFrame; delim=';')
orders08_01 = CSV.read("Orders08_01.csv", DataFrame)
VehiclesandTerminals08_01 = CSV.read("VehiclesandTerminals08_01.csv", DataFrame; delim=';')

distances08_01_modified = CSV.read("Distances08_01_modified.csv", DataFrame; delim=';')
orders08_01_modified = CSV.read("Orders08_01_modified.csv", DataFrame)
VehiclesandTerminals08_01_modified = CSV.read("VehiclesandTerminals08_01_modified.csv", DataFrame; delim=';')

distances08_02 = CSV.read("Distances08_02.csv", DataFrame; delim=';')
orders08_02 = CSV.read("Orders08_02.csv", DataFrame)
VehiclesandTerminals08_02 = CSV.read("VehiclesandTerminals08_02.csv", DataFrame; delim=';')

distances08_02_modified = CSV.read("Distances08_02_modified.csv", DataFrame; delim=',')
orders08_02_modified = CSV.read("Orders08_02_modified.csv", DataFrame)
VehiclesandTerminals08_02_modified = CSV.read("VehiclesandTerminals08_02_modified.csv", DataFrame; delim=';')

distances08_03 = CSV.read("Distances08_03.csv", DataFrame; delim=';')
orders08_03 = CSV.read("Orders08_03.csv", DataFrame)
VehiclesandTerminals08_03 = CSV.read("VehiclesandTerminals08_03.csv", DataFrame; delim=';')

distances08_04 = CSV.read("Distances08_04.csv", DataFrame; delim=';')
orders08_04 = CSV.read("Orders08_04.csv", DataFrame)
VehiclesandTerminals08_04 = CSV.read("VehiclesandTerminals08_04.csv", DataFrame; delim=';')



distances09 = CSV.read("Distances09.csv", DataFrame; delim=',')
orders09 = CSV.read("Orders09.csv", DataFrame)
VehiclesandTerminals09 = CSV.read("VehiclesandTerminals09.csv", DataFrame; delim=',')

distances10 = CSV.read("Distances10.csv", DataFrame; delim=',')
orders10 = CSV.read("Orders10.csv", DataFrame)
VehiclesandTerminals10 = CSV.read("VehiclesandTerminals10.csv", DataFrame; delim=',')



# Number of locations 
n01large = length(unique(distances01large[!, "Location ID From"]))
n01A = length(unique(distances01A[!, "Location ID From"]))
n01B = length(unique(distances01B[!, "Location ID From"]))
n01C = length(unique(distances01C[!, "Location ID From"]))
n01D = length(unique(distances01D[!, "Location ID From"]))
n02 = length(unique(distances02[!, "Location ID From"]))
n03 = length(unique(distances03[!, "Location ID From"]))
n04A = length(unique(distances04A[!, "Location ID From"]))
n04B = length(unique(distances04B[!, "Location ID From"]))
n05_01 = length(unique(distances05_01[!, "Location ID From"]))
n05_02 = length(unique(distances05_02[!, "Location ID From"]))
n05_03 = length(unique(distances05_03[!, "Location ID From"]))
n05_04 = length(unique(distances05_04[!, "Location ID From"]))
n05_05 = length(unique(distances05_05[!, "Location ID From"]))
n05_06 = length(unique(distances05_06[!, "Location ID From"]))
n05_07 = length(unique(distances05_07[!, "Location ID From"]))
n05_08 = length(unique(distances05_08[!, "Location ID From"]))
n05_09 = length(unique(distances05_09[!, "Location ID From"]))
n05_10 = length(unique(distances05_10[!, "Location ID From"]))
n05_11 = length(unique(distances05_11[!, "Location ID From"]))
n05_12 = length(unique(distances05_12[!, "Location ID From"]))
n05_13 = length(unique(distances05_13[!, "Location ID From"]))
n05_14 = length(unique(distances05_14[!, "Location ID From"]))
n05_15 = length(unique(distances05_15[!, "Location ID From"]))
n05_16 = length(unique(distances05_16[!, "Location ID From"]))
n05_17 = length(unique(distances05_17[!, "Location ID From"]))
n05_18 = length(unique(distances05_18[!, "Location ID From"]))
n06_01 = length(unique(distances06_01[!, "Location ID From"]))
n06_02 = length(unique(distances06_02[!, "Location ID From"]))
n06_03 = length(unique(distances06_03[!, "Location ID From"]))
n06_04 = length(unique(distances06_04[!, "Location ID From"]))
n06_05 = length(unique(distances06_05[!, "Location ID From"]))
n06_06 = length(unique(distances06_06[!, "Location ID From"]))
n06_07 = length(unique(distances06_07[!, "Location ID From"]))
n06_08 = length(unique(distances06_08[!, "Location ID From"]))
n06_09 = length(unique(distances06_09[!, "Location ID From"]))
n06_10 = length(unique(distances06_10[!, "Location ID From"]))
n06_11 = length(unique(distances06_11[!, "Location ID From"]))
n06_12 = length(unique(distances06_12[!, "Location ID From"]))
n06_13 = length(unique(distances06_13[!, "Location ID From"]))
n06_14 = length(unique(distances06_14[!, "Location ID From"]))
n06_15 = length(unique(distances06_15[!, "Location ID From"]))
n06_16 = length(unique(distances06_16[!, "Location ID From"]))
n07_01 = length(unique(distances07_01[!, "Location ID From"]))
n07_02 = length(unique(distances07_02[!, "Location ID From"]))
n07_03 = length(unique(distances07_03[!, "Location ID From"]))
n07_03_modified = length(unique(distances07_03_modified[!, "Location ID From"]))
n07_04 = length(unique(distances07_04[!, "Location ID From"]))
n07_05 = length(unique(distances07_05[!, "Location ID From"]))
n07_06 = length(unique(distances07_06[!, "Location ID From"]))
n07_07 = length(unique(distances07_07[!, "Location ID From"]))
n07_08 = length(unique(distances07_08[!, "Location ID From"]))
n07_09 = length(unique(distances07_09[!, "Location ID From"]))
n07_09_modified = length(unique(distances07_09_modified[!, "Location ID From"]))
n07_10 = length(unique(distances07_10[!, "Location ID From"]))
n07_11 = length(unique(distances07_11[!, "Location ID From"]))
n07_11_modified = length(unique(distances07_11_modified[!, "Location ID From"]))
n07_12 = length(unique(distances07_12[!, "Location ID From"]))
n07_12_modified = length(unique(distances07_12_modified[!, "Location ID From"]))
n07_13 = length(unique(distances07_13[!, "Location ID From"]))
n07_14 = length(unique(distances07_14[!, "Location ID From"]))
n07_15 = length(unique(distances07_15[!, "Location ID From"]))
n07_16 = length(unique(distances07_16[!, "Location ID From"]))
n07_16_modified = length(unique(distances07_16_modified[!, "Location ID From"]))
n07_17 = length(unique(distances07_17[!, "Location ID From"]))
n08_01 = length(unique(distances08_01[!, "Location ID From"]))
n08_01_modified = length(unique(distances08_01_modified[!, "Location ID From"]))
n08_02 = length(unique(distances08_02[!, "Location ID From"]))
n08_02_modified = length(unique(distances08_02_modified[!, "Location ID From"]))
n08_03 = length(unique(distances08_03[!, "Location ID From"]))
n08_04 = length(unique(distances08_04[!, "Location ID From"]))
n09 = length(unique(distances09[!, "Location ID From"]))
n10 = length(unique(distances10[!, "Location ID From"]))



# Initialize an integer matrix for distances
d01large = zeros(Int, n01large, n01large)
d01A = zeros(Int, n01A, n01A)
d01B = zeros(Int, n01B, n01B)
d01C = zeros(Int, n01C, n01C)
d01D = zeros(Int, n01D, n01D)
d02 = zeros(Int, n02, n02)
d03 = zeros(Int, n03, n03)
d04A = zeros(Int, n04A, n04A)
d04B = zeros(Int, n04B, n04B)
d05_01 = zeros(Int, n05_01, n05_01)
d05_02 = zeros(Int, n05_02, n05_02)
d05_03 = zeros(Int, n05_03, n05_03)
d05_04 = zeros(Int, n05_04, n05_04)
d05_05 = zeros(Int, n05_05, n05_05)
d05_06 = zeros(Int, n05_06, n05_06)
d05_07 = zeros(Int, n05_07, n05_07)
d05_08 = zeros(Int, n05_08, n05_08)
d05_09 = zeros(Int, n05_09, n05_09)
d05_10 = zeros(Int, n05_10, n05_10)
d05_11 = zeros(Int, n05_11, n05_11)
d05_12 = zeros(Int, n05_12, n05_12)
d05_13 = zeros(Int, n05_13, n05_13)
d05_14 = zeros(Int, n05_14, n05_14)
d05_15 = zeros(Int, n05_15, n05_15)
d05_16 = zeros(Int, n05_16, n05_16)
d05_17 = zeros(Int, n05_17, n05_17)
d05_18 = zeros(Int, n05_18, n05_18)
d06_01 = zeros(Int, n06_01, n06_01)
d06_02 = zeros(Int, n06_02, n06_02)
d06_03 = zeros(Int, n06_03, n06_03)
d06_04 = zeros(Int, n06_04, n06_04)
d06_05 = zeros(Int, n06_05, n06_05)
d06_06 = zeros(Int, n06_06, n06_06)
d06_07 = zeros(Int, n06_07, n06_07)
d06_08 = zeros(Int, n06_08, n06_08)
d06_09 = zeros(Int, n06_09, n06_09)
d06_10 = zeros(Int, n06_10, n06_10)
d06_11 = zeros(Int, n06_11, n06_11)
d06_12 = zeros(Int, n06_12, n06_12)
d06_13 = zeros(Int, n06_13, n06_13)
d06_14 = zeros(Int, n06_14, n06_14)
d06_15 = zeros(Int, n06_15, n06_15)
d06_16 = zeros(Int, n06_16, n06_16)
d07_01 = zeros(Int, n07_01, n07_01)
d07_02 = zeros(Int, n07_02, n07_02)
d07_03 = zeros(Int, n07_03, n07_03)
d07_03_modified = zeros(Int, n07_03_modified, n07_03_modified)
d07_04 = zeros(Int, n07_04, n07_04)
d07_05 = zeros(Int, n07_05, n07_05)
d07_06 = zeros(Int, n07_06, n07_06)
d07_07 = zeros(Int, n07_07, n07_07)
d07_08 = zeros(Int, n07_08, n07_08)
d07_09 = zeros(Int, n07_09, n07_09)
d07_09_modified = zeros(Int, n07_09_modified, n07_09_modified)
d07_10 = zeros(Int, n07_10, n07_10)
d07_11 = zeros(Int, n07_11, n07_11)
d07_11_modified = zeros(Int, n07_11_modified, n07_11_modified)
d07_12 = zeros(Int, n07_12, n07_12)
d07_12_modified = zeros(Int, n07_12_modified, n07_12_modified)
d07_13 = zeros(Int, n07_13, n07_13)
d07_14 = zeros(Int, n07_14, n07_14)
d07_15 = zeros(Int, n07_15, n07_15)
d07_16 = zeros(Int, n07_16, n07_16)
d07_16_modified = zeros(Int, n07_16_modified, n07_16_modified)
d07_17 = zeros(Int, n07_17, n07_17)
d08_01 = zeros(Int, n08_01, n08_01)
d08_01_modified = zeros(Int, n08_01_modified, n08_01_modified)
d08_02 = zeros(Int, n08_02, n08_02)
d08_02_modified = zeros(Int, n08_02_modified, n08_02_modified)
d08_03 = zeros(Int, n08_03, n08_03)
d08_04 = zeros(Int, n08_04, n08_04)
d09 = zeros(Int, n09, n09)
d10 = zeros(Int, n10, n10)


# Set 01large
for row in eachrow(distances01large)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d01large[from_node, to_node] = distance
end
# Fill in the distance matrix based on CSV data - Set 01A
for row in eachrow(distances01A)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d01A[from_node, to_node] = distance
end
# Set 01B
for row in eachrow(distances01B)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d01B[from_node, to_node] = distance
end
# Set 01C
for row in eachrow(distances01C)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d01C[from_node, to_node] = distance
end
# Set 01D
for row in eachrow(distances01D)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d01D[from_node, to_node] = distance
end
# Set 02
for row in eachrow(distances02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d02[from_node, to_node] = distance
end
# Set 03
for row in eachrow(distances03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d03[from_node, to_node] = distance
end
# Set 04A
for row in eachrow(distances04A)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d04A[from_node, to_node] = distance
end
# Set 04B
for row in eachrow(distances04B)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d04B[from_node, to_node] = distance
end
# Set 05_01
for row in eachrow(distances05_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_01[from_node, to_node] = distance
end
# Set 05_02
for row in eachrow(distances05_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_02[from_node, to_node] = distance
end
# Set 05_03
for row in eachrow(distances05_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_03[from_node, to_node] = distance
end
# Set 05_04
for row in eachrow(distances05_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_04[from_node, to_node] = distance
end
# Set 05_05
for row in eachrow(distances05_05)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_05[from_node, to_node] = distance
end
# Set 05_06
for row in eachrow(distances05_06)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_06[from_node, to_node] = distance
end
# Set 05_07
for row in eachrow(distances05_07)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_07[from_node, to_node] = distance
end
# Set 05_08
for row in eachrow(distances05_08)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_08[from_node, to_node] = distance
end
# Set 05_09
for row in eachrow(distances05_09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_09[from_node, to_node] = distance
end
# Set 05_10
for row in eachrow(distances05_10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_10[from_node, to_node] = distance
end
# Set 05_11
for row in eachrow(distances05_11)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_11[from_node, to_node] = distance
end
# Set 05_12
for row in eachrow(distances05_12)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_12[from_node, to_node] = distance
end
# Set 05_13
for row in eachrow(distances05_13)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_13[from_node, to_node] = distance
end
# Set 05_14
for row in eachrow(distances05_14)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_14[from_node, to_node] = distance
end
# Set 05_15
for row in eachrow(distances05_15)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_15[from_node, to_node] = distance
end
# Set 05_16
for row in eachrow(distances05_16)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_16[from_node, to_node] = distance
end
# Set 05_17
for row in eachrow(distances05_17)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_17[from_node, to_node] = distance
end
# Set 05_18
for row in eachrow(distances05_18)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d05_18[from_node, to_node] = distance
end
# Set 06_01
for row in eachrow(distances06_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_01[from_node, to_node] = distance
end
# Set 06_02
for row in eachrow(distances06_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_02[from_node, to_node] = distance
end
# Set 06_03
for row in eachrow(distances06_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_03[from_node, to_node] = distance
end
# Set 06_04
for row in eachrow(distances06_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_04[from_node, to_node] = distance
end
# Set 06_05
for row in eachrow(distances06_05)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_05[from_node, to_node] = distance
end
# Set 06_06
for row in eachrow(distances06_06)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_06[from_node, to_node] = distance
end
# Set 06_07
for row in eachrow(distances06_07)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_07[from_node, to_node] = distance
end
# Set 06_08
for row in eachrow(distances06_08)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_08[from_node, to_node] = distance
end
# Set 06_09
for row in eachrow(distances06_09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_09[from_node, to_node] = distance
end
# Set 06_10
for row in eachrow(distances06_10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_10[from_node, to_node] = distance
end
# Set 06_11
for row in eachrow(distances06_11)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_11[from_node, to_node] = distance
end
# Set 06_12
for row in eachrow(distances06_12)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_12[from_node, to_node] = distance
end
# Set 06_13
for row in eachrow(distances06_13)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_13[from_node, to_node] = distance
end
# Set 06_14
for row in eachrow(distances06_14)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_14[from_node, to_node] = distance
end
# Set 06_15
for row in eachrow(distances06_15)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_15[from_node, to_node] = distance
end
# Set 06_16
for row in eachrow(distances06_16)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d06_16[from_node, to_node] = distance
end
# Set 07_01
for row in eachrow(distances07_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_01[from_node, to_node] = distance
end
# Set 07_02
for row in eachrow(distances07_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_02[from_node, to_node] = distance
end
# Set 07_03
for row in eachrow(distances07_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_03[from_node, to_node] = distance
end
# Set 07_03_modified
for row in eachrow(distances07_03_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_03_modified[from_node, to_node] = distance
end
# Set 07_04
for row in eachrow(distances07_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_04[from_node, to_node] = distance
end
# Set 07_05
for row in eachrow(distances07_05)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_05[from_node, to_node] = distance
end
# Set 07_06
for row in eachrow(distances07_06)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_06[from_node, to_node] = distance
end
# Set 07_07
for row in eachrow(distances07_07)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_07[from_node, to_node] = distance
end
# Set 07_08
for row in eachrow(distances07_08)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_08[from_node, to_node] = distance
end
# Set 07_09
for row in eachrow(distances07_09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_09[from_node, to_node] = distance
end
# Set 07_09_modified
for row in eachrow(distances07_09_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_09_modified[from_node, to_node] = distance
end
# Set 07_10
for row in eachrow(distances07_10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_10[from_node, to_node] = distance
end
# Set 07_11
for row in eachrow(distances07_11)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_11[from_node, to_node] = distance
end
# Set 07_11_modified
for row in eachrow(distances07_11_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_11_modified[from_node, to_node] = distance
end
# Set 07_12
for row in eachrow(distances07_12)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_12[from_node, to_node] = distance
end
# Set 07_12_modified
for row in eachrow(distances07_12_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_12_modified[from_node, to_node] = distance
end
# Set 07_13
for row in eachrow(distances07_13)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_13[from_node, to_node] = distance
end
# Set 07_14
for row in eachrow(distances07_14)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_14[from_node, to_node] = distance
end
# Set 07_15
for row in eachrow(distances07_15)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_15[from_node, to_node] = distance
end
# Set 07_16
for row in eachrow(distances07_16)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_16[from_node, to_node] = distance
end
# Set 07_16_modified
for row in eachrow(distances07_16_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_16_modified[from_node, to_node] = distance
end
# Set 07_17
for row in eachrow(distances07_17)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d07_17[from_node, to_node] = distance
end
# Set 08_01
for row in eachrow(distances08_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d08_01[from_node, to_node] = distance
end
# Set 08_01_modified
for row in eachrow(distances08_01_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d08_01_modified[from_node, to_node] = distance
end
# Set 08_02
for row in eachrow(distances08_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d08_02[from_node, to_node] = distance
end
# Set 08_02_modified
for row in eachrow(distances08_02_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d08_02_modified[from_node, to_node] = distance
end
# Set 08_03
for row in eachrow(distances08_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d08_03[from_node, to_node] = distance
end
# Set 08_04
for row in eachrow(distances08_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d08_04[from_node, to_node] = distance
end
# Set 09
for row in eachrow(distances09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d09[from_node, to_node] = distance
end
# Set 10
for row in eachrow(distances10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    distance = Int(row["Distance (m)"])  # Convert to integer

    # Populate the matrix with integer values
    d10[from_node, to_node] = distance
end




# Initialize an integer matrix for distances
t01large = zeros(Int, n01large, n01large)
t01A = zeros(Int, n01A, n01A)
t01B = zeros(Int, n01B, n01B)
t01C = zeros(Int, n01C, n01C)
t01D = zeros(Int, n01D, n01D)
t02 = zeros(Int, n02, n02)
t03 = zeros(Int, n03, n03)
t04A = zeros(Int, n04A, n04A)
t04B = zeros(Int, n04B, n04B)
t05_01 = zeros(Int, n05_01, n05_01)
t05_02 = zeros(Int, n05_02, n05_02)
t05_03 = zeros(Int, n05_03, n05_03)
t05_04 = zeros(Int, n05_04, n05_04)
t05_05 = zeros(Int, n05_05, n05_05)
t05_06 = zeros(Int, n05_06, n05_06)
t05_07 = zeros(Int, n05_07, n05_07)
t05_08 = zeros(Int, n05_08, n05_08)
t05_09 = zeros(Int, n05_09, n05_09)
t05_10 = zeros(Int, n05_10, n05_10)
t05_11 = zeros(Int, n05_11, n05_11)
t05_12 = zeros(Int, n05_12, n05_12)
t05_13 = zeros(Int, n05_13, n05_13)
t05_14 = zeros(Int, n05_14, n05_14)
t05_15 = zeros(Int, n05_15, n05_15)
t05_16 = zeros(Int, n05_16, n05_16)
t05_17 = zeros(Int, n05_17, n05_17)
t05_18 = zeros(Int, n05_18, n05_18)
t06_01 = zeros(Int, n06_01, n06_01)
t06_02 = zeros(Int, n06_02, n06_02)
t06_03 = zeros(Int, n06_03, n06_03)
t06_04 = zeros(Int, n06_04, n06_04)
t06_05 = zeros(Int, n06_05, n06_05)
t06_06 = zeros(Int, n06_06, n06_06)
t06_07 = zeros(Int, n06_07, n06_07)
t06_08 = zeros(Int, n06_08, n06_08)
t06_09 = zeros(Int, n06_09, n06_09)
t06_10 = zeros(Int, n06_10, n06_10)
t06_11 = zeros(Int, n06_11, n06_11)
t06_12 = zeros(Int, n06_12, n06_12)
t06_13 = zeros(Int, n06_13, n06_13)
t06_14 = zeros(Int, n06_14, n06_14)
t06_15 = zeros(Int, n06_15, n06_15)
t06_16 = zeros(Int, n06_16, n06_16)
t07_01 = zeros(Int, n07_01, n07_01)
t07_02 = zeros(Int, n07_02, n07_02)
t07_03 = zeros(Int, n07_03, n07_03)
t07_03_modified = zeros(Int, n07_03_modified, n07_03_modified)
t07_04 = zeros(Int, n07_04, n07_04)
t07_05 = zeros(Int, n07_05, n07_05)
t07_06 = zeros(Int, n07_06, n07_06)
t07_07 = zeros(Int, n07_07, n07_07)
t07_08 = zeros(Int, n07_08, n07_08)
t07_09 = zeros(Int, n07_09, n07_09)
t07_09_modified = zeros(Int, n07_09_modified, n07_09_modified)
t07_10 = zeros(Int, n07_10, n07_10)
t07_11 = zeros(Int, n07_11, n07_11)
t07_11_modified = zeros(Int, n07_11_modified, n07_11_modified)
t07_12 = zeros(Int, n07_12, n07_12)
t07_12_modified = zeros(Int, n07_12_modified, n07_12_modified)
t07_13 = zeros(Int, n07_13, n07_13)
t07_14 = zeros(Int, n07_14, n07_14)
t07_15 = zeros(Int, n07_15, n07_15)
t07_16 = zeros(Int, n07_16, n07_16)
t07_16_modified = zeros(Int, n07_16_modified, n07_16_modified)
t07_17 = zeros(Int, n07_17, n07_17)
t08_01 = zeros(Int, n08_01, n08_01)
t08_01_modified = zeros(Int, n08_01_modified, n08_01_modified)
t08_02 = zeros(Int, n08_02, n08_02)
t08_02_modified = zeros(Int, n08_02_modified, n08_02_modified)
t08_03 = zeros(Int, n08_03, n08_03)
t08_04 = zeros(Int, n08_04, n08_04)
t09 = zeros(Int, n09, n09)
t10 = zeros(Int, n10, n10)


# Set 01 large
for row in eachrow(distances01large)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t01large[from_node, to_node] = time
end
# Fill in the distance matrix based on CSV data - Set 01A
for row in eachrow(distances01A)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t01A[from_node, to_node] = time
end
# Set 01B
for row in eachrow(distances01B)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t01B[from_node, to_node] = time
end
# Set 01C
for row in eachrow(distances01C)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t01C[from_node, to_node] = time
end
# Set 01D
for row in eachrow(distances01D)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t01D[from_node, to_node] = time
end
# Set 02
for row in eachrow(distances02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t02[from_node, to_node] = time
end
# Set 03
for row in eachrow(distances03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t03[from_node, to_node] = time
end
# Set 04A
for row in eachrow(distances04A)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t04A[from_node, to_node] = time
end
# Set 04B
for row in eachrow(distances04B)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t04B[from_node, to_node] = time
end
# Set 05_01
for row in eachrow(distances05_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_01[from_node, to_node] = time
end
# Set 05_02
for row in eachrow(distances05_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_02[from_node, to_node] = time
end
# Set 05_03
for row in eachrow(distances05_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_03[from_node, to_node] = time
end
# Set 05_04
for row in eachrow(distances05_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_04[from_node, to_node] = time
end
# Set 05_05
for row in eachrow(distances05_05)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_05[from_node, to_node] = time
end
# Set 05_06
for row in eachrow(distances05_06)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_06[from_node, to_node] = time
end
# Set 05_07
for row in eachrow(distances05_07)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_07[from_node, to_node] = time
end
# Set 05_08
for row in eachrow(distances05_08)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_08[from_node, to_node] = time
end
# Set 05_09
for row in eachrow(distances05_09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_09[from_node, to_node] = time
end
# Set 05_10
for row in eachrow(distances05_10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_10[from_node, to_node] = time
end
# Set 05_11
for row in eachrow(distances05_11)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_11[from_node, to_node] = time
end
# Set 05_12
for row in eachrow(distances05_12)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_12[from_node, to_node] = time
end
# Set 05_13
for row in eachrow(distances05_13)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_13[from_node, to_node] = time
end
# Set 05_14
for row in eachrow(distances05_14)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_14[from_node, to_node] = time
end
# Set 05_15
for row in eachrow(distances05_15)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_15[from_node, to_node] = time
end
# Set 05_16
for row in eachrow(distances05_16)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_16[from_node, to_node] = time
end
# Set 05_17
for row in eachrow(distances05_17)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_17[from_node, to_node] = time
end
# Set 05_18
for row in eachrow(distances05_18)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t05_18[from_node, to_node] = time
end
# Set 06_01
for row in eachrow(distances06_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_01[from_node, to_node] = time
end
# Set 06_02
for row in eachrow(distances06_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_02[from_node, to_node] = time
end
# Set 06_03
for row in eachrow(distances06_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_03[from_node, to_node] = time
end
# Set 06_04
for row in eachrow(distances06_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_04[from_node, to_node] = time
end
# Set 06_05
for row in eachrow(distances06_05)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_05[from_node, to_node] = time
end
# Set 06_06
for row in eachrow(distances06_06)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_06[from_node, to_node] = time
end
# Set 06_07
for row in eachrow(distances06_07)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_07[from_node, to_node] = time
end
# Set 06_08
for row in eachrow(distances06_08)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_08[from_node, to_node] = time
end
# Set 06_09
for row in eachrow(distances06_09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_09[from_node, to_node] = time
end
# Set 06_10
for row in eachrow(distances06_10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_10[from_node, to_node] = time
end
# Set 06_11
for row in eachrow(distances06_11)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_11[from_node, to_node] = time
end
# Set 06_12
for row in eachrow(distances06_12)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_12[from_node, to_node] = time
end
# Set 06_13
for row in eachrow(distances06_13)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_13[from_node, to_node] = time
end
# Set 06_14
for row in eachrow(distances06_14)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_14[from_node, to_node] = time
end
# Set 06_15
for row in eachrow(distances06_15)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_15[from_node, to_node] = time
end
# Set 06_16
for row in eachrow(distances06_16)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t06_16[from_node, to_node] = time
end
# Set 07_01
for row in eachrow(distances07_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_01[from_node, to_node] = time
end
# Set 07_02
for row in eachrow(distances07_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_02[from_node, to_node] = time
end
# Set 07_03
for row in eachrow(distances07_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_03[from_node, to_node] = time
end
# Set 07_03_modified
for row in eachrow(distances07_03_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_03_modified[from_node, to_node] = time
end
# Set 07_04
for row in eachrow(distances07_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_04[from_node, to_node] = time
end
# Set 07_05
for row in eachrow(distances07_05)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_05[from_node, to_node] = time
end
# Set 07_06
for row in eachrow(distances07_06)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_06[from_node, to_node] = time
end
# Set 07_07
for row in eachrow(distances07_07)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_07[from_node, to_node] = time
end
# Set 07_08
for row in eachrow(distances07_08)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_08[from_node, to_node] = time
end
# Set 07_09
for row in eachrow(distances07_09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_09[from_node, to_node] = time
end
# Set 07_09_modified
for row in eachrow(distances07_09_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_09_modified[from_node, to_node] = time
end
# Set 07_10
for row in eachrow(distances07_10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_10[from_node, to_node] = time
end
# Set 07_11
for row in eachrow(distances07_11)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_11[from_node, to_node] = time
end
# Set 07_11_modified
for row in eachrow(distances07_11_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_11_modified[from_node, to_node] = time
end
# Set 07_12
for row in eachrow(distances07_12)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_12[from_node, to_node] = time
end
# Set 07_12_modified
for row in eachrow(distances07_12_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_12_modified[from_node, to_node] = time
end
# Set 07_13
for row in eachrow(distances07_13)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_13[from_node, to_node] = time
end
# Set 07_14
for row in eachrow(distances07_14)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_14[from_node, to_node] = time
end
# Set 07_15
for row in eachrow(distances07_15)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_15[from_node, to_node] = time
end
# Set 07_16
for row in eachrow(distances07_16)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_16[from_node, to_node] = time
end
# Set 07_16_modified
for row in eachrow(distances07_16_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_16_modified[from_node, to_node] = time
end
# Set 07_17
for row in eachrow(distances07_17)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t07_17[from_node, to_node] = time
end
# Set 08_01
for row in eachrow(distances08_01)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t08_01[from_node, to_node] = time
end
# Set 08_01_modified
for row in eachrow(distances08_01_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t08_01_modified[from_node, to_node] = time
end
# Set 08_02
for row in eachrow(distances08_02)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t08_02[from_node, to_node] = time
end
# Set 08_02_modified
for row in eachrow(distances08_02_modified)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t08_02_modified[from_node, to_node] = time
end
# Set 08_03
for row in eachrow(distances08_03)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t08_03[from_node, to_node] = time
end
# Set 08_04
for row in eachrow(distances08_04)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t08_04[from_node, to_node] = time
end
# Set 09
for row in eachrow(distances09)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t09[from_node, to_node] = time
end
# Set 10
for row in eachrow(distances10)
    from_node = row["Location ID From"]
    to_node = row["Location ID To"]
    time = Int(row["Driving Time (s)"])  # Convert to integer

    # Populate the matrix with integer values
    t10[from_node, to_node] = time
end




# Function to convert Dates.Time to seconds from 00:00
function time_to_seconds(time::Time)
    return hour(time) * 3600 + minute(time) * 60 + second(time)
end  



# Convert time windows to seconds

ei01large = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders01large)])
li01large = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders01large)])

ei01A = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders01A)])
li01A = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders01A)])

ei01B = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders01B)])
li01B = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders01B)])

ei01C = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders01C)])
li01C = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders01C)])

ei01D = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders01D)])
li01D = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders01D)])

ei02 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders02)])
li02 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders02)])

ei03 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders03)])
li03 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders03)])

ei04A = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders04A)])
li04A = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders04A)])

ei04B = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders04B)])
li04B = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders04B)])

ei05_01 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_01)])
li05_01 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_01)])

ei05_02 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_02)])
li05_02 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_02)])

ei05_03 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_03)])
li05_03 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_03)])

ei05_04 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_04)])
li05_04 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_04)])

ei05_05 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_05)])
li05_05 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_05)])

ei05_06 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_06)])
li05_06 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_06)])

ei05_07 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_07)])
li05_07 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_07)])

ei05_08 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_08)])
li05_08 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_08)])

ei05_09 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_09)])
li05_09 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_09)])

ei05_10 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_10)])
li05_10 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_10)])

ei05_11 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_11)])
li05_11 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_11)])

ei05_12 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_12)])
li05_12 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_12)])

ei05_13 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_13)])
li05_13 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_13)])

ei05_14 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_14)])
li05_14 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_14)])

ei05_15 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_15)])
li05_15 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_15)])

ei05_16 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_16)])
li05_16 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_16)])

ei05_17 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_17)])
li05_17 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_17)])

ei05_18 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders05_18)])
li05_18 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders05_18)])

ei06_01 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_01)])
li06_01 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_01)])

ei06_02 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_02)])
li06_02 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_02)])

ei06_03 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_03)])
li06_03 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_03)])

ei06_04 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_04)])
li06_04 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_04)])

ei06_05 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_05)])
li06_05 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_05)])

ei06_06 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_06)])
li06_06 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_06)])

ei06_07 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_07)])
li06_07 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_07)])

ei06_08 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_08)])
li06_08 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_08)])

ei06_09 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_09)])
li06_09 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_09)])

ei06_10 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_10)])
li06_10 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_10)])

ei06_11 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_11)])
li06_11 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_11)])

ei06_12 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_12)])
li06_12 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_12)])

ei06_13 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_13)])
li06_13 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_13)])

ei06_14 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_14)])
li06_14 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_14)])

ei06_15 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_15)])
li06_15 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_15)])

ei06_16 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders06_16)])
li06_16 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders06_16)])

ei07_01 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_01)])
li07_01 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_01)])

ei07_02 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_02)])
li07_02 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_02)])

ei07_03 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_03)])
li07_03 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_03)])

ei07_03_modified = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_03_modified)])
li07_03_modified = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_03_modified)])

ei07_04 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_04)])
li07_04 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_04)])

ei07_05 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_05)])
li07_05 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_05)])

ei07_06 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_06)])
li07_06 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_06)])

ei07_07 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_07)])
li07_07 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_07)])

ei07_08 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_08)])
li07_08 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_08)])

ei07_09 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_09)])
li07_09 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_09)])

ei07_09_modified = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_09_modified)])
li07_09_modified = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_09_modified)])

ei07_10 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_10)])
li07_10 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_10)])

ei07_11 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_11)])
li07_11 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_11)])

ei07_11_modified = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_11_modified)])
li07_11_modified = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_11_modified)])

ei07_12 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_12)])
li07_12 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_12)])

ei07_12_modified = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_12_modified)])
li07_12_modified = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_12_modified)])

ei07_13 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_13)])
li07_13 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_13)])

ei07_14 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_14)])
li07_14 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_14)])

ei07_15 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_15)])
li07_15 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_15)])

ei07_16 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_16)])
li07_16 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_16)])

ei07_16_modified = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_16_modified)])
li07_16_modified = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_16_modified)])

ei07_17 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders07_17)])
li07_17 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders07_17)])

ei08_01 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders08_01)])
li08_01 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders08_01)])

ei08_01_modified = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders08_01_modified)])
li08_01_modified = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders08_01_modified)])

ei08_02 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders08_02)])
li08_02 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders08_02)])

ei08_02_modified = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders08_02_modified)])
li08_02_modified = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders08_02_modified)])

ei08_03 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders08_03)])
li08_03 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders08_03)])

ei08_04 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders08_04)])
li08_04 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders08_04)])

ei09 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders09)])
li09 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders09)])

ei10 = vcat(0, [time_to_seconds(row["Time Window Open (HH:MM)"]) for row in eachrow(orders10)])
li10 = vcat(100000, [time_to_seconds(row["Time Window Close (HH:MM)"]) for row in eachrow(orders10)])




# Handling times - Prepend 0 for the depot
h01large = vcat(0, orders01large[!, "Handling Time (s)"])
h01A = vcat(0, orders01A[!, "Handling Time (s)"])
h01B = vcat(0, orders01B[!, "Handling Time (s)"])
h01C = vcat(0, orders01C[!, "Handling Time (s)"])
h01D = vcat(0, orders01D[!, "Handling Time (s)"])
h02 = vcat(0, orders02[!, "Handling Time (s)"])
h03 = vcat(0, orders03[!, "Handling Time (s)"])
h04A = vcat(0, orders04A[!, "Handling Time (s)"])
h04B = vcat(0, orders04B[!, "Handling Time (s)"])
h05_01 = vcat(0, orders05_01[!, "Handling Time (s)"])
h05_02 = vcat(0, orders05_02[!, "Handling Time (s)"])
h05_03 = vcat(0, orders05_03[!, "Handling Time (s)"])
h05_04 = vcat(0, orders05_04[!, "Handling Time (s)"])
h05_05 = vcat(0, orders05_05[!, "Handling Time (s)"])
h05_06 = vcat(0, orders05_06[!, "Handling Time (s)"])
h05_07 = vcat(0, orders05_07[!, "Handling Time (s)"])
h05_08 = vcat(0, orders05_08[!, "Handling Time (s)"])
h05_09 = vcat(0, orders05_09[!, "Handling Time (s)"])
h05_10 = vcat(0, orders05_10[!, "Handling Time (s)"])
h05_11 = vcat(0, orders05_11[!, "Handling Time (s)"])
h05_12 = vcat(0, orders05_12[!, "Handling Time (s)"])
h05_13 = vcat(0, orders05_13[!, "Handling Time (s)"])
h05_14 = vcat(0, orders05_14[!, "Handling Time (s)"])
h05_15 = vcat(0, orders05_15[!, "Handling Time (s)"])
h05_16 = vcat(0, orders05_16[!, "Handling Time (s)"])
h05_17 = vcat(0, orders05_17[!, "Handling Time (s)"])
h05_18 = vcat(0, orders05_18[!, "Handling Time (s)"])
h06_01 = vcat(0, orders06_01[!, "Handling Time (s)"])
h06_02 = vcat(0, orders06_02[!, "Handling Time (s)"])
h06_03 = vcat(0, orders06_03[!, "Handling Time (s)"])
h06_04 = vcat(0, orders06_04[!, "Handling Time (s)"])
h06_05 = vcat(0, orders06_05[!, "Handling Time (s)"])
h06_06 = vcat(0, orders06_06[!, "Handling Time (s)"])
h06_07 = vcat(0, orders06_07[!, "Handling Time (s)"])
h06_08 = vcat(0, orders06_08[!, "Handling Time (s)"])
h06_09 = vcat(0, orders06_09[!, "Handling Time (s)"])
h06_10 = vcat(0, orders06_10[!, "Handling Time (s)"])
h06_11 = vcat(0, orders06_11[!, "Handling Time (s)"])
h06_12 = vcat(0, orders06_12[!, "Handling Time (s)"])
h06_13 = vcat(0, orders06_13[!, "Handling Time (s)"])
h06_14 = vcat(0, orders06_14[!, "Handling Time (s)"])
h06_15 = vcat(0, orders06_15[!, "Handling Time (s)"])
h06_16 = vcat(0, orders06_16[!, "Handling Time (s)"])
h07_01 = vcat(0, orders07_01[!, "Handling Time (s)"])
h07_02 = vcat(0, orders07_02[!, "Handling Time (s)"])
h07_03 = vcat(0, orders07_03[!, "Handling Time (s)"])
h07_03_modified = vcat(0, orders07_03_modified[!, "Handling Time (s)"])
h07_04 = vcat(0, orders07_04[!, "Handling Time (s)"])
h07_05 = vcat(0, orders07_05[!, "Handling Time (s)"])
h07_06 = vcat(0, orders07_06[!, "Handling Time (s)"])
h07_07 = vcat(0, orders07_07[!, "Handling Time (s)"])
h07_08 = vcat(0, orders07_08[!, "Handling Time (s)"])
h07_09 = vcat(0, orders07_09[!, "Handling Time (s)"])
h07_09_modified = vcat(0, orders07_09_modified[!, "Handling Time (s)"])
h07_10 = vcat(0, orders07_10[!, "Handling Time (s)"])
h07_11 = vcat(0, orders07_11[!, "Handling Time (s)"])
h07_11_modified = vcat(0, orders07_11_modified[!, "Handling Time (s)"])
h07_12 = vcat(0, orders07_12[!, "Handling Time (s)"])
h07_12_modified = vcat(0, orders07_12_modified[!, "Handling Time (s)"])
h07_13 = vcat(0, orders07_13[!, "Handling Time (s)"])
h07_14 = vcat(0, orders07_14[!, "Handling Time (s)"])
h07_15 = vcat(0, orders07_15[!, "Handling Time (s)"])
h07_16 = vcat(0, orders07_16[!, "Handling Time (s)"])
h07_16_modified = vcat(0, orders07_16_modified[!, "Handling Time (s)"])
h07_17 = vcat(0, orders07_17[!, "Handling Time (s)"])
h08_01 = vcat(0, orders08_01[!, "Handling Time (s)"])
h08_01_modified = vcat(0, orders08_01_modified[!, "Handling Time (s)"])
h08_02 = vcat(0, orders08_02[!, "Handling Time (s)"])
h08_02_modified = vcat(0, orders08_02_modified[!, "Handling Time (s)"])
h08_03 = vcat(0, orders08_03[!, "Handling Time (s)"])
h08_04 = vcat(0, orders08_04[!, "Handling Time (s)"])
h09 = vcat(0, orders09[!, "Handling Time (s)"])
h10 = vcat(0, orders10[!, "Handling Time (s)"])




# Calculate r as the average seconds per meter
total_distance01large = sum(d01large)
total_time01large = sum(t01large)
q01large = total_time01large > 0 ? total_time01large / total_distance01large : 1.0  # Set q to 1 if total_time is zero 

total_distance01A = sum(d01A)
total_time01A = sum(t01A)
q01A = total_time01A > 0 ? total_time01A / total_distance01A : 1.0  # Set q to 1 if total_time is zero 

total_distance01B = sum(d01B)
total_time01B = sum(t01B)
q01B = total_time01B > 0 ? total_time01B / total_distance01B : 1.0  # Set q to 1 if total_time is zero 

total_distance01C = sum(d01C)
total_time01C = sum(t01C)
q01C = total_time01C > 0 ? total_time01C / total_distance01C : 1.0  # Set q to 1 if total_time is zero 

total_distance01D = sum(d01D)
total_time01D = sum(t01D)
q01D = total_time01D > 0 ? total_time01D / total_distance01D : 1.0  # Set q to 1 if total_time is zero 

total_distance02 = sum(d02)
total_time02 = sum(t02)
q02 = total_time02 > 0 ? total_time02 / total_distance02 : 1.0  # Set q to 1 if total_time is zero 

total_distance03 = sum(d03)
total_time03 = sum(t03)
q03 = total_time03 > 0 ? total_time03 / total_distance03 : 1.0  # Set q to 1 if total_time is zero 

total_distance04A = sum(d04A)
total_time04A = sum(t04A)
q04A = total_time04A > 0 ? total_time04A / total_distance04A : 1.0  # Set q to 1 if total_time is zero 

total_distance04B = sum(d04B)
total_time04B = sum(t04B)
q04B = total_time04B > 0 ? total_time04B / total_distance04B : 1.0  # Set q to 1 if total_time is zero 

total_distance05_01 = sum(d05_01)
total_time05_01 = sum(t05_01)
q05_01 = total_time05_01 > 0 ? total_time05_01 / total_distance05_01 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_02 = sum(d05_02)
total_time05_02 = sum(t05_02)
q05_02 = total_time05_02 > 0 ? total_time05_02 / total_distance05_02 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_03 = sum(d05_03)
total_time05_03 = sum(t05_03)
q05_03 = total_time05_03 > 0 ? total_time05_03 / total_distance05_03 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_04 = sum(d05_04)
total_time05_04 = sum(t05_04)
q05_04 = total_time05_04 > 0 ? total_time05_04 / total_distance05_04 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_05 = sum(d05_05)
total_time05_05 = sum(t05_05)
q05_05 = total_time05_05 > 0 ? total_time05_05 / total_distance05_05 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_06 = sum(d05_06)
total_time05_06 = sum(t05_06)
q05_06 = total_time05_06 > 0 ? total_time05_06 / total_distance05_06 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_07 = sum(d05_07)
total_time05_07 = sum(t05_07)
q05_07 = total_time05_07 > 0 ? total_time05_07 / total_distance05_07 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_08 = sum(d05_08)
total_time05_08 = sum(t05_08)
q05_08 = total_time05_08 > 0 ? total_time05_08 / total_distance05_08 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_09 = sum(d05_09)
total_time05_09 = sum(t05_09)
q05_09 = total_time05_09 > 0 ? total_time05_09 / total_distance05_09 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_10 = sum(d05_10)
total_time05_10 = sum(t05_10)
q05_10 = total_time05_10 > 0 ? total_time05_10 / total_distance05_10 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_11 = sum(d05_11)
total_time05_11 = sum(t05_11)
q05_11 = total_time05_11 > 0 ? total_time05_11 / total_distance05_11 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_12 = sum(d05_12)
total_time05_12 = sum(t05_12)
q05_12 = total_time05_12 > 0 ? total_time05_12 / total_distance05_12 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_13 = sum(d05_13)
total_time05_13 = sum(t05_13)
q05_13 = total_time05_13 > 0 ? total_time05_13 / total_distance05_13 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_14 = sum(d05_14)
total_time05_14 = sum(t05_14)
q05_14 = total_time05_14 > 0 ? total_time05_14 / total_distance05_14 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_15 = sum(d05_15)
total_time05_15 = sum(t05_15)
q05_15 = total_time05_15 > 0 ? total_time05_15 / total_distance05_15 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_16 = sum(d05_16)
total_time05_16 = sum(t05_16)
q05_16 = total_time05_16 > 0 ? total_time05_16 / total_distance05_16 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_17 = sum(d05_17)
total_time05_17 = sum(t05_17)
q05_17 = total_time05_17 > 0 ? total_time05_17 / total_distance05_17 : 1.0  # Set q to 1 if total_time is zero 

total_distance05_18 = sum(d05_18)
total_time05_18 = sum(t05_18)
q05_18 = total_time05_18 > 0 ? total_time05_18 / total_distance05_18 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_01 = sum(d06_01)
total_time06_01 = sum(t06_01)
q06_01 = total_time06_01 > 0 ? total_time06_01 / total_distance06_01 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_02 = sum(d06_02)
total_time06_02 = sum(t06_02)
q06_02 = total_time06_02 > 0 ? total_time06_02 / total_distance06_02 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_03 = sum(d06_03)
total_time06_03 = sum(t06_03)
q06_03 = total_time06_03 > 0 ? total_time06_03 / total_distance06_03 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_04 = sum(d06_04)
total_time06_04 = sum(t06_04)
q06_04 = total_time06_04 > 0 ? total_time06_04 / total_distance06_04 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_05 = sum(d06_05)
total_time06_05 = sum(t06_05)
q06_05 = total_time06_05 > 0 ? total_time06_05 / total_distance06_05 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_06 = sum(d06_06)
total_time06_06 = sum(t06_06)
q06_06 = total_time06_06 > 0 ? total_time06_06 / total_distance06_06 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_07 = sum(d06_07)
total_time06_07 = sum(t06_07)
q06_07 = total_time06_07 > 0 ? total_time06_07 / total_distance06_07 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_08 = sum(d06_08)
total_time06_08 = sum(t06_08)
q06_08 = total_time06_08 > 0 ? total_time06_08 / total_distance06_08 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_09 = sum(d06_09)
total_time06_09 = sum(t06_09)
q06_09 = total_time06_09 > 0 ? total_time06_09 / total_distance06_09 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_10 = sum(d06_10)
total_time06_10 = sum(t06_10)
q06_10 = total_time06_10 > 0 ? total_time06_10 / total_distance06_10 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_11 = sum(d06_11)
total_time06_11 = sum(t06_11)
q06_11 = total_time06_11 > 0 ? total_time06_11 / total_distance06_11 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_12 = sum(d06_12)
total_time06_12 = sum(t06_12)
q06_12 = total_time06_12 > 0 ? total_time06_12 / total_distance06_12 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_13 = sum(d06_13)
total_time06_13 = sum(t06_13)
q06_13 = total_time06_13 > 0 ? total_time06_13 / total_distance06_13 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_14 = sum(d06_14)
total_time06_14 = sum(t06_14)
q06_14 = total_time06_14 > 0 ? total_time06_14 / total_distance06_14 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_15 = sum(d06_15)
total_time06_15 = sum(t06_15)
q06_15 = total_time06_15 > 0 ? total_time06_15 / total_distance06_15 : 1.0  # Set q to 1 if total_time is zero 

total_distance06_16 = sum(d06_16)
total_time06_16 = sum(t06_16)
q06_16 = total_time06_16 > 0 ? total_time06_16 / total_distance06_16 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_01 = sum(d07_01)
total_time07_01 = sum(t07_01)
q07_01 = total_time07_01 > 0 ? total_time07_01 / total_distance07_01 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_02 = sum(d07_02)
total_time07_02 = sum(t07_02)
q07_02 = total_time07_02 > 0 ? total_time07_02 / total_distance07_02 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_03 = sum(d07_03)
total_time07_03 = sum(t07_03)
q07_03 = total_time07_03 > 0 ? total_time07_03 / total_distance07_03 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_03_modified = sum(d07_03_modified)
total_time07_03_modified = sum(t07_03_modified)
q07_03_modified = total_time07_03_modified > 0 ? total_time07_03_modified / total_distance07_03_modified : 1.0  # Set q to 1 if total_time is zero 

total_distance07_04 = sum(d07_04)
total_time07_04 = sum(t07_04)
q07_04 = total_time07_04 > 0 ? total_time07_04 / total_distance07_04 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_05 = sum(d07_05)
total_time07_05 = sum(t07_05)
q07_05 = total_time07_05 > 0 ? total_time07_05 / total_distance07_05 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_06 = sum(d07_06)
total_time07_06 = sum(t07_06)
q07_06 = total_time07_06 > 0 ? total_time07_06 / total_distance07_06 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_07 = sum(d07_07)
total_time07_07 = sum(t07_07)
q07_07 = total_time07_07 > 0 ? total_time07_07 / total_distance07_07 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_08 = sum(d07_08)
total_time07_08 = sum(t07_08)
q07_08 = total_time07_08 > 0 ? total_time07_08 / total_distance07_08 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_09 = sum(d07_09)
total_time07_09 = sum(t07_09)
q07_09 = total_time07_09 > 0 ? total_time07_09 / total_distance07_09 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_09_modified = sum(d07_09_modified)
total_time07_09_modified = sum(t07_09_modified)
q07_09_modified = total_time07_09_modified > 0 ? total_time07_09_modified / total_distance07_09_modified : 1.0  # Set q to 1 if total_time is zero 

total_distance07_10 = sum(d07_10)
total_time07_10 = sum(t07_10)
q07_10 = total_time07_10 > 0 ? total_time07_10 / total_distance07_10 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_11 = sum(d07_11)
total_time07_11 = sum(t07_11)
q07_11 = total_time07_11 > 0 ? total_time07_11 / total_distance07_11 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_11_modified = sum(d07_11_modified)
total_time07_11_modified = sum(t07_11_modified)
q07_11_modified = total_time07_11_modified > 0 ? total_time07_11_modified / total_distance07_11_modified : 1.0  # Set q to 1 if total_time is zero 

total_distance07_12 = sum(d07_12)
total_time07_12 = sum(t07_12)
q07_12 = total_time07_12 > 0 ? total_time07_12 / total_distance07_12 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_12_modified = sum(d07_12_modified)
total_time07_12_modified = sum(t07_12_modified)
q07_12_modified = total_time07_12_modified > 0 ? total_time07_12_modified / total_distance07_12_modified : 1.0  # Set q to 1 if total_time is zero 

total_distance07_13 = sum(d07_13)
total_time07_13 = sum(t07_13)
q07_13 = total_time07_13 > 0 ? total_time07_13 / total_distance07_13 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_14 = sum(d07_14)
total_time07_14 = sum(t07_14)
q07_14 = total_time07_14 > 0 ? total_time07_14 / total_distance07_14 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_15 = sum(d07_15)
total_time07_15 = sum(t07_15)
q07_15 = total_time07_15 > 0 ? total_time07_15 / total_distance07_15 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_16 = sum(d07_16)
total_time07_16 = sum(t07_16)
q07_16 = total_time07_16 > 0 ? total_time07_16 / total_distance07_16 : 1.0  # Set q to 1 if total_time is zero 

total_distance07_16_modified = sum(d07_16_modified)
total_time07_16_modified = sum(t07_16_modified)
q07_16_modified = total_time07_16_modified > 0 ? total_time07_16_modified / total_distance07_16_modified : 1.0  # Set q to 1 if total_time is zero 

total_distance07_17 = sum(d07_17)
total_time07_17 = sum(t07_17)
q07_17 = total_time07_17 > 0 ? total_time07_17 / total_distance07_17 : 1.0  # Set q to 1 if total_time is zero 

total_distance08_01 = sum(d08_01)
total_time08_01 = sum(t08_01)
q08_01 = total_time08_01 > 0 ? total_time08_01 / total_distance08_01 : 1.0  # Set q to 1 if total_time is zero 

total_distance08_01_modified = sum(d08_01_modified)
total_time08_01_modified = sum(t08_01_modified)
q08_01_modified = total_time08_01_modified > 0 ? total_time08_01_modified / total_distance08_01_modified : 1.0  # Set q to 1 if total_time is zero 

total_distance08_02 = sum(d08_02)
total_time08_02 = sum(t08_02)
q08_02 = total_time08_02 > 0 ? total_time08_02 / total_distance08_02 : 1.0  # Set q to 1 if total_time is zero 

total_distance08_02_modified = sum(d08_02_modified)
total_time08_02_modified = sum(t08_02_modified)
q08_02_modified = total_time08_02_modified > 0 ? total_time08_02_modified / total_distance08_02_modified : 1.0  # Set q to 1 if total_time is zero 

total_distance08_03 = sum(d08_03)
total_time08_03 = sum(t08_03)
q08_03 = total_time08_03 > 0 ? total_time08_03 / total_distance08_03 : 1.0  # Set q to 1 if total_time is zero 

total_distance08_04 = sum(d08_04)
total_time08_04 = sum(t08_04)
q08_04 = total_time08_04 > 0 ? total_time08_04 / total_distance08_04 : 1.0  # Set q to 1 if total_time is zero 

total_distance09 = sum(d09)
total_time09 = sum(t09)
q09 = total_time09 > 0 ? total_time09 / total_distance09 : 1.0  # Set q to 1 if total_time is zero 

total_distance10 = sum(d10)
total_time10 = sum(t10)
q10 = total_time10 > 0 ? total_time10 / total_distance10 : 1.0  # Set q to 1 if total_time is zero


