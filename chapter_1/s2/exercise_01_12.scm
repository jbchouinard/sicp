; SICP Exercise 1.12



; Find ith element of the jth row of Pascal's triangle
(define (pascal-row j i)
    (cond
        ((= i 0) 1)
        ((= i j) 1)
        (else (+ (pascal-row (- j 1) i)
                 (pascal-row (- j 1) (- i 1))))))

; Find nth number of Pascal's triangle
(define (pascal n)
    (define (iter pos row)
        (cond
            ((= n 0) 1)
            ((>  (+ pos row) n)
                (pascal-row (- row 1) (modulo n pos)))
            (else
                (iter (+ row pos) (+ row 1)))))
    (iter 0 1))
