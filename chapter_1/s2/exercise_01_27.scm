`; SICP Exercise 1.27



(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (slow-prime? n)
    (define (try-it a)
        (= (expmod a n n) a))
    (define (slow-prime-iter a n)
        (cond ((= a n) #t)
              (else (if (not (try-it a))
                #f
                (slow-prime-iter (+ a 1) n)))))
    (slow-prime-iter 1 n))
