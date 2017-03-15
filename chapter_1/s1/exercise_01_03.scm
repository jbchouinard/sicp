; SICP Exercise 1.3



(define (square x) (* x x))

(define (f x y z) (cond
    ((and (<= x y) (<= x z))
        (+ (square y) (square z)))
    ((and (<= y x) (<= y z))
        (+ (square x) (square z)))
    (else
        (+ (square x) (square y)))))
