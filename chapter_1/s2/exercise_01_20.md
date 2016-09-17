# SICP Exercise 1.20

## Normal order

Let rem = remainder for brevity.

    (gcd 206 40)
    (gcd 40 (rem 206 40)))
    (gcd (rem 206 40) (rem 40 (rem 206 40))) ; rem applied once in predicate
    (gcd (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40)))) ; rem applied twice in predicate
    (gcd (rem (rem 206 40) (rem 40 (rem 206 40))) (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40))))) ; rem applied 4 times in predicate
    (rem (rem 206 40) (rem 40 (rem 206 40))) ; rem applied 7 times in predicate
    2

The remainder procedure is applied (1+2+4+7+4) = 18 times.

## Applicative order

    (gcd 206 40)
    (gcd 40 (remainder 206 40))
    (gcd 40 6)
    (gcd 6 (remainder 40 6))
    (gcd 6 4)
    (gcd 4 (remainder 6 4))
    (gcd 4 2)
    (gcd 2 (remainder 4 2))
    (gcd 2 0)
    2

The remainder procedure is applied 4 times.
