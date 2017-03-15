; SICP Exercise 1.7



(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

; square root using newton's method
; criterion: guess produces error < 0.001
(define (sqrt x)
    (define (improve guess x)
        (average guess (/ x guess)))
    (define (good-enough? guess x)
        (< (abs (- (square guess) x)) 0.001))
    (define (sqrt-iter guess x)
        (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))
    (sqrt-iter 1.0 x))

; square root using newton's method
; criterion: guess changes by less than 0.1%
(define (sqrt' x)
    (define (improve guess x)
        (average guess (/ x guess)))
    (define (good-enough? lastguess guess)
        (<  (abs (- lastguess guess))
            (* 0.001 guess)))
    (define (sqrt-iter lastguess guess x)
        (if (good-enough? lastguess guess)
            guess
            (sqrt-iter guess (improve guess x) x)))
    (sqrt-iter 0.0 1.0 x))
