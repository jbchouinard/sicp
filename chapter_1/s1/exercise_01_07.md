# SICP Exercise 1.7

With this definition of good-enough?:

    (define (good-enough? guess x)
        (< (abs (- (square guess) x)) 0.001))
    
    (define (sqrt-iter guess x)
        (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))

We get the following results:

    > (sqrt 4)
    2.0000000929222947
    > (sqrt 0.00004)
    0.031675095080232185

That's not very good. Let's improve that.

    (define (good-enough? lastguess guess)
        (<  (abs (- lastguess guess)) 
            (* 0.001 guess)))

    (define (sqrt-iter lastguess guess x)
        (if (good-enough? lastguess guess)
            guess
            (sqrt-iter guess (improve guess x) x)))

Now we get:

    > (sqrt 4)
    2.0000000929222947
    > (sqrt 0.000004)
    0.0020000003065983023
