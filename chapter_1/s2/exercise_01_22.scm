; SICP Exercise 1.22



; Searching for divisors
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; Searching for primes between a and b
(define (search-for-primes a b)
    (define (report-prime elapsed-time)
      (display " *** ")
      (display elapsed-time))
    (define (start-prime-test n start-time)
      (cond ((prime? n)
          (newline)
          (display n)
          (report-prime (- (runtime) start-time)))))
    (cond ((<= a b)
        (start-prime-test a (runtime))
        (search-for-primes (+ a 1) b))))

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
