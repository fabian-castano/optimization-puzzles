using  Random

mutable struct Solution
    vals::Array{Float64,1}
    fitness::Float64
end

mutable struct Population
    solutions::Array{Solution,1}
    best::Float32 
    worst::Float32 
end

function random_initialization(vec_size::Int)
    a = vec_size
    vals = []
    for i in 1:vec_size-1
        push!(vals, rand()*a)
        a -= vals[i]
    end
    push!(vals, a)
    return vals
end

normalize(x,n) = n.*x/sum(x)

function insert_into_sorted(sol::Solution, population::Population)
    for i in 1:length(population.solutions)
        if sol.fitness < population.solutions[i].fitness
            insert!(population.solutions, i, sol)
            return
        end
    end
    push!(population.solutions, sol)
end

function crossover(sol1::Solution, sol2::Solution,objective)
    # binary mask crossover
    n_vals = length(sol1.vals)
    vals = []
    for i in 1:length(sol1.vals)
        if rand() > 0.5
            push!(vals, sol1.vals[i])
        else
            push!(vals, sol2.vals[i])
        end
    end
    vals = normalize(vals,5)
    return Solution(vals, objective(vals))
    
end

function mutation(sol::Solution,objective)
    # random mutation
    i = rand(1:length(sol.vals))
    delta = sol.vals[i]*(0.5+rand())
    while true
        j = rand(1:length(sol.vals))
        if j != i
            break
        end        
    end
    j = rand(1:length(sol.vals))
    delta = minimum([delta, sol.vals[j]])
    sol.vals[i] += delta
    sol.vals[j] -= delta
    return Solution(sol.vals, objective(sol.vals))
end



f(x::Vector{Float64}) = sum(1/prod(x[1:i]) for i in 1:length(x))

function evolve_population(vasr_to_sum::Int,pop_size::Int, generations::Int,offspring::Int,objective)
    start_time = time()
    time_to_best = 0
    population = Population([], 100000000000000, 0)
    
    for i in 1:pop_size
        vals = normalize(random_initialization(vasr_to_sum),vasr_to_sum)
        
        fitness = objective(vals)
        sol = Solution(vals, fitness)
        
        if sol.fitness < population.best
            population.best = sol.fitness
            time_to_best
        end
        if sol.fitness > population.worst
            population.worst = sol.fitness
        end
        insert_into_sorted(sol, population)
    end
    
    #println(" ======================= Evolution ======================= ")
    for i in 1:generations
        for i in 1:offspring
            sol1 = population.solutions[rand(1:end)]
            sol2 = population.solutions[rand(1:end)]
            new_sol = crossover(sol1, sol2,objective)
            if rand() < 0.05 
                new_sol = mutation(new_sol, objective)
            end
            if new_sol.fitness < population.best
                population.best = new_sol.fitness
                time_to_best = time()-start_time
            end
            if new_sol.fitness > population.worst
                population.worst = new_sol.fitness
            end
            insert_into_sorted(new_sol, population)
            
        end
        population.solutions = population.solutions[1:pop_size]
    end
    println("Best objective: ", population.best)
    println(" Time to best: ", time_to_best)
    println( " Best solution: ", round.(population.solutions[1].vals, digits=5))
end




start_time = time()
evolve_population(5, 50, 500, 20, f)

println("Time: ", time()-start_time)

