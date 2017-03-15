; SICP Exercise 1.31



; Iterative process
(define (product term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))))
    (iter a 1))

; Recursive process
(define (product' term a next b)
    (if (> a b)
        1
        (* (term a)
           (product' term (next a) next b))))
