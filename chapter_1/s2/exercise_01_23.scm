; SICP Exercise 1.23



; Searching for divisors
(define (smallest-divisor n)
    (define (next n)
        (if (= n 2) 3 (+ n 2)))
    (define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (next test-divisor)))))
    (define (divides? a b)
        (= (remainder b a) 0))
    (find-divisor n 2))

(define (prime? n)
  (= n (smallest-divisor n)))

; Searching for n primes larger than min
(define (search-for-n-primes n min)
    (define (iter-prime n x start-time)
        (cond ((prime? x)
                (newline)
                (display x)
                (display " *** ")
                (display (- (runtime) start-time))
                (iter-prime (- n 1) (+ x 1) (runtime)))
            ((> n 0)
                (iter-prime n (+ x 1) (runtime)))))
    (iter-prime n min (runtime)))
