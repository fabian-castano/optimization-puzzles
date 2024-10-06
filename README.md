# optimization-puzzles

## Problem 1

## Optimization approaches used for solving random puzzles posted on linkedin

On October 5 2024 Meinoff Sellman published an optimization puzzle on Linkedin that caught my attention. 

![image](https://github.com/user-attachments/assets/30a98928-95a5-4fec-ae1a-2cbf5c5435ac)



The puzzle was about finding the optimal solution for a simple non-linear optimization problem. The problem was to find the optimal values for x and y that minimize the following function:

$\min : f(x, y,z,u,v) = \frac{1}{x} + \frac{1}{xy} + \frac{1}{xyz} + \frac{1}{xyzu} + \frac{1}{xyzuv}$

Subject to the following constraints:

$g(x, y, z, u, v) = x + y + z + u + v = 5$

The problem was to find the optimal values for x, y, z, u, and v that minimize the function f(x, y, z, u, v) subject to the constraint g(x, y, z, u, v) = 5.

While checking some threads derived from the post, there were some interesting approaches to solve the problem using commercial and open-source optimization solvers. The authors used Inside-Opt, Hexali and Ipopt to solve the problem and criticized the performance of commercial solvers specialized in MIP and LP problems, like Gurobi and CPLEX. I decided to try to solve the problem using a very simple genetic algorithm and compare the results with the ones obtained by the authors. 

While the authors claimed to have solutions tha were optimal within a very short time, I was able to find a solution that was very close to the optimal solution in pretty much the same time. The authors claimed to have found the optimal solution in less than 0.1 seconds, while my solution took the same, yet  using an old-fashioned genetic algorithm with very few customizations.

In my opinion this simple example shows that there is still room for simple optimization algorithms to solve complex problems withouth the need of sophisticated optimization solvers. This observation can be very useful for practitioners that do not have access to commercial solvers or are not willing to pay for them to solve their problems (particularly important for small companies and startups).