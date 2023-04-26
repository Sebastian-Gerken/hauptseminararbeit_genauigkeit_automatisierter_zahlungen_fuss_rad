import Pkg; Pkg.add("CSV")
using CSV, DataFrames
path = "C:/Users/sebas/OneDrive/8. Semester/Hauptseminararbeit/Auswertung/data/gt_data/Saarbruecken_OTCamera04_FR20_2022-10-17_13-15-00_v5.csv"
df = CSV.read( path, DataFrame, delim = ",")


for i in 0:1000000
    println(i)
end

@noinline function myloop()
    @inbounds for i in 0:1000000
        println(i)
    end
end

myloop() # call the function to run the loop

usin CUDA
# Define two matrices
a = CUDA.rand(1024, 1024)
b = CUDA.rand(1024, 1024)

# Multiply the matrices on the GPU
c = CUDA.@time a * b

# Print the result
println(c)

function count()
    s = 0
    for i in 1:10000000
        s += i
    end
    return s
end

@time count()
