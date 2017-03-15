; SICP Exercise 2.5



(define (factor-count n fac)
  (define (iter k i)
    (if (= 0 (remainder k fac))
      (iter (/ k fac) (+ i 1))
      i))
  (iter n 0))

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car n)
  (factor-count n 2))

(define (cdr n)
  (factor-count n 3))
