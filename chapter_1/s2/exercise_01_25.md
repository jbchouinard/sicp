# SICP Exercise 1.25

This new procedure would not be as good. For small numbers it would be as fast, or faster, since the original procedure executes an extra `remainder` operation at each iteration. However, very large exponents would cause problems - that is, very large candidate primes.

The original `expmod` procedure relies on the fact that \\[(x * y) \bmod m = [(x \bmod m) * (y \bmod m)] \bmod m\\] to keep the terms small. Taking the remainder at each step of the iteration ensures that, even with a very large exponent, the terms involved in the multiplication do not get bigger than m.

If multiplication was truly \\(\Theta(1)\\) in number of steps for arbitrarily large integers, the fast-exp implementation would be faster (though it would take more space, \\(\Theta(log(n)\\) instead of \\(\Theta(1)\\). But that's not really the case with real world computers; multiplying extremely large numbers takes more time than small numbers, and the program may run into overflow errors if the terms become bigger than can be practically stored.