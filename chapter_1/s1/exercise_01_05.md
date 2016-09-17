# SICP Exercise 1.5

## Normal order

The procedure is fully expanded:

1.

    (test 0 (p))

2.

    (if (= 0 0)
        0
        (p)))

Then reduced:

3.

    0

## Applicative order

First the subexpressions are evaluated:

1.

    (test 0 (p))

(p) is evaluated to (p)

2.

    (test 0 (p))

(p) is evaluated to (p)

And so on ad infinitum. The procedure never terminates.
