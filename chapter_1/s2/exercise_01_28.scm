; SICP Exercise 1.28



(define (square x) (* x x))

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

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else #f)))
