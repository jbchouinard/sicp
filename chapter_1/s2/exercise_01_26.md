# SICP Exercise 1.26

Just look at it.

Instead of a (linear) iterative process with depth \\(log(n)\\), he has created a binary tree shaped process with depth \\(log(n)\\), since expmod calls itself twice (in one of the branches of the conditional) recursively. In the best case, where each node has only one child, the number of nodes (equal to the number of steps) will grow as log(n), but in the worst case, where each node has 2 children, the number of nodes (equal to the number of steps) will grow as n:

Let m be the depth of the tree

The full tree will have \\(2^m - 1\\) nodes

Here m = log(n)

\\(2^{log(n)} = n\\)

(The best case basically never happens, that would require repeatedly getting an odd exponent, but a call to expmod with odd exponent is always followed by a call with an even exponent is it's called with exp - 1).
