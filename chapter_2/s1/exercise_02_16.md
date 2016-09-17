# SICP Exercise 2.16

As explained in 2.15, the intervals produced by the package depend on the number of repetitions of the interval variables in the algebraic expression.

There isn't a way around that with the way we have designed our interval package. There is no way for the operators to know that they are dealing with repeated variables.

A package that does not have this shortcoming would not be implemented at the operator level. It would have to take the algebraic expression as a whole, and replace all instances of each variable by a single value in the range. (For example, letting all instances of 'A' take on the lower bound value.) To compute the interval of the algebraic expression, the package would have to find the combinations of values that minimize and maximize the algebraic expression.

For more complex algebraic expressions, it's not clear that the expression will be minimized or maximized by a combination of the upper-bound and lower-bound values of the variables.

For example, the upper-bound of the expression: \\(A*A*(-1)\\), where A is the interval (-1, 1) occurs at the value A=0, not at either endpoint.

The task is not impossible, but it is very hard.
