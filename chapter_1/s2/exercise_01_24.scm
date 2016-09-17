; SICP Exercise 1.24

(load "~/.schemerc.scm")

; Fermat test
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

; Searching for n primes larger than min, fermat test
(define (fast-search-for-n-primes n min times)
    (define (iter-prime n x start-time)
        (cond ((fast-prime? x times)
                (newline)
                (display x)
                (display " *** ")
                (display (- (runtime) start-time))
                (iter-prime (- n 1) (+ x 1) (runtime)))
            ((> n 0)
                (iter-prime n (+ x 1) (runtime)))))
    (iter-prime n min (runtime)))
