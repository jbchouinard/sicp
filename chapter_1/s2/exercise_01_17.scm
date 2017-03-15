; SICP Exercise 1.17



(define (double x) (* x 2))

(define (halve x) (/ x 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (mult a b)
  (if (= b 0)
      0
      (+ a (mult a (- b 1)))))

(define (fast-mult a b)
    (cond ((= b 0) 0)
          ((even? b) (fast-mult (double a) (halve b)))
          (else (+ a (fast-mult a (- b 1))))))
