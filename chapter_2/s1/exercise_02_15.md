# SICP Exercise 2.15

Eva Lu Ator is right. The problem is that the package treats each repetition of the same variable as independent; each copy is allowed to take on different values when computing the new range.

For example, if we compute A/A, where A is an interval with all positive values, the div operator takes the lower bound of the numerator with the upper bound of the denominator to compute the lower bound of the result. However, in reality, the As in the numerator and the denominator must take on the same value.

Par2 is indeed a better program. Par1 produces intervals that are too loose.
