; SICP Math Package

(require "sicp.func")


; ------------------------- Basic Math -------------------------
(define (inc x) (+ x 1))

(define (positive? x)
  (if (> x 0)
    true
    false))

(define (negative? x)
  (if (< x 0)
    true
    false))

(define (average x y)
  (/ (+ x y) 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (odd? n)
  (not (even? n)))

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (congruent-mod-n? x y n) (= (modulo x n) (modulo y n)))

(define (expt b n)
    (define (expt-iter a b n)
        (cond ((= n 0) a)
              ((even? n) (expt-iter a (square b) (/ n 2)))
              (else (expt-iter (* a b) b (- n 1)))))
    (expt-iter 1 b n))

(define (log2trunc x) (floor (/ (log x) (log 2))))

(define (nth-root x n)
  (define f (lambda (y) (/ x (expt y (- n 1)))))
  (fixed-point ((repeated average-damp (log2trunc n)) f) 1.0))

(define (sqrt x) (nth-root x 2))

(define (cbrt x) (nth-root x 3))

(define (gcd a b)
    (if (= b 0)
    a
    (gcd b (remainder a b))))

(define (cont-frac n d k)
  (define (cont-frac-iter i c)
    (if (= i 0)
      c
      (cont-frac-iter (- i 1) (/ (n i) (+ (d i) c)))))
  (cont-frac-iter k 0))

(define (sum term a next b) (accumulate + 0 term a next b))

(define (product term a next b) (accumulate * 1 term a next b))


; ------------------------- Primes -------------------------
(define (fast-prime? n times)
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

; I dont have strong mathematical reasons for calling fast-prime?
; with LOG(N) repetitions; it's a compromise solution to wanting
; the prime? procedure to be relatively reliable and fast
(define (prime? n)
    (if (= (modulo n 2) 0)
        (if (= n 2)
            #t
            #f)
        (fast-prime? n (round (log n)))))


; ------------------------- Calculus -------------------------
(define dx 1.0e-6)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (smooth f dx)
  (lambda (x)
    (/ (+ (f (- x dx))(f x) (f (+ x dx))) 3)))

(define (integral f a b n)
    (define (dx) (/ (- b a) n))
    (define (add-dx x) (+ x (dx)))
    (* (sum f (+ a (/ (dx) 2.0)) add-dx b) (dx)))

(define (integral-simpson f a b n)
    (define (h) (/ (- b a) n))
    (define (coeff k)
        (cond ((= k 0) 1.0)
              ((= k n) 1.0)
              (else (+ 2.0 (* 2.0 (modulo k 2))))))
    (define (simpson-term k)
        (* (coeff k) (f (+ a (* k (h))))))
    (define (simpson-next k)
        (+ 1 k))
    (* (/ (h) 3.0) (sum simpson-term 0 simpson-next n)))

(define tolerance 1.0e-6)

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))

(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (let ((next (improve guess)))
      (if (good-enough? guess next)
        next
        (iter next)))))

; Find an approx. fixed point of the procedure f
; x is a fixed point of the function  y -> f(y) iff
;    f(x) = x
(define (fixed-point f first-guess)
  ((iterative-improve
    close-enough?
    (lambda (guess) (f guess)))
   first-guess))

(define (average-damp f)
  (lambda (x) (average x (f x))))


; ------------------------- Matrix Operations -------------------------
(define (dot-product v w)
  (fold-right + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product v x)) m))

(define (transpose mat)
  (fold-right-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v) (matrix-*-vector cols v)) m)))
