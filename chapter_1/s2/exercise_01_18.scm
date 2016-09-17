; SICP Exercise 1.18

(load "~/.schemerc.scm")

(define (double x) (* x 2))

(define (halve x) (/ x 2))

(define (even? n)
  (= (remainder n 2) 0))

; Naive procedure (theta n)
(define (mult a b)
  (if (= b 0)
      0
      (+ a (mult a (- b 1)))))

; Fast procedure, recursive (theta log n)
(define (fast-mult a b)
    (cond ((= b 0) 0)
          ((even? b) (fast-mult (double a) (halve b)))
          (else (+ a (fast-mult a (- b 1))))))

; Fast procedure, iterative (theta log n in steps, theta 1 in space)
(define (fast-mult' a b)
    (define (mult-iter a b c)
        (cond ((= b 0) c)
              ((even? b) (mult-iter (double a) (halve b) c))
              (else (mult-iter a (- b 1) (+ c a)))))
    (mult-iter a b 0))
