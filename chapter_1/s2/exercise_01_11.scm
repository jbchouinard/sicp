; SICP Exercise 1.11



; recursive process
(define (f n)
    (if (< n 3)
        n
        (+  (f (- n 1))
            (* 2 (f (- n 2)))
            (* 3 (f (- n 3))))))

; iterative process
(define (f' n)
    (define (f-iter a b c counter)
        (if (= counter 0)
                c
                (f-iter b c (+ c (* 2 b) (* 3 a)) (- counter 1))))
    (if (< n 3)
        n
        (f-iter 0 1 2 (- n 2))))
