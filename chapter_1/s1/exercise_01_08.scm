; SICP Exercise 1.8



(define (square x) (* x x))

; cube root using Newton's method
(define (cbrt x)
    (define (improve guess x)
        (/  (+  (* 2 guess)
                (/ x (square guess)))
            3))
    (define (good-enough? lastguess guess)
        (<  (abs (- lastguess guess))
            (* 0.001 guess)))
    (define (cbrt-iter lastguess guess x)
        (if (good-enough? lastguess guess)
            guess
            (cbrt-iter guess (improve guess x) x)))
    (cbrt-iter 0.0 1.0 x))
