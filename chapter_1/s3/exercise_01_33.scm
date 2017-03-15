; SICP Exercise 1.33



(define (square x) (* x x))

(define (inc x) (+ 1 x))

(define (identity x) x)

; Prime?
(define (fast-prime? n times)
    (define (congruent-mod-n? x y n) (= (modulo x n) (modulo y n)))
    (define (expmod base exp m)
        (define (nontrivial-sqrt? x)
            ; returns 0 to signal a nontrivial squareroot of 1 mod n
            (cond ((= x 1) (remainder (square x) m))
                  ((= x (- m 1)) (remainder (square x) m))
                  ((congruent-mod-n? (square x) 1 m) 0)
                  (else (remainder (square x) m))))
        (cond ((= exp 0) 1)
              ((even? exp)
                (nontrivial-sqrt? (expmod base (/ exp 2) m)))
              (else
                (remainder (* base (expmod base (- exp 1) m))
                           m))))
    (define (miller-rabin-test n)
      (define (try-it a)
        (not (= (expmod a (- n 1) n) 0)))
      (try-it (+ 1 (random (- n 1)))))
  (cond ((= times 0) #t)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (prime? n)
    (if (= (modulo n 2) 0)
        (if (= n 2)
            #t
            #f)
        (fast-prime? n 100)))

; GCD
(define (gcd a b)
    (if (= b 0)
    a
    (gcd b (remainder a b))))

; Iterative process
(define (filtered-accumulate filter combiner null-value term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (if (filter a)
                (iter (next a) (combiner result (term a)))
                (iter (next a) result))))
    (iter a null-value))


(define (sum-square-primes a b)
    (filtered-accumulate prime? + 0 square a inc b))

(define (product-relative-primes n)
    (define (relative-prime? a)
        (= (gcd a n) 1))
    (filtered-accumulate relative-prime? * 1 identity 1 inc n))
