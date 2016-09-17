# SICP Exercise 1.23

### Inefficient small-divisor procedure

First 3 primes > 1,000,000,000,000

    1000000000039 *** 1.1999999999999997
    1000000000061 *** 1.2000000000000002
    1000000000063 *** 1.2000000000000002

First 3 primes > 10,000,000,000,000
    
    10000000000037 *** 3.88
    10000000000051 *** 3.8599999999999994
    10000000000099 *** 3.919999999999998

### Better small-divisor procedure

First 3 primes > 1,000,000,000,000

    1000000000039 *** .76
    1000000000061 *** .74
    1000000000063 *** .7399999999999998

First 3 primes > 10,000,000,000,000

    0000000000037 *** 2.3800000000000003
    10000000000051 *** 2.34
    10000000000099 *** 2.360000000000001

The ratio is not quite 2. I would guess that this is because there is overhead in the algorithm; the small-divisor procedure is not the only part of the algorithm that takes time. The procedure is also computing and and displaying runtimes. The `next` procedure adds an extra condition to check.