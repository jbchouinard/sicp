; SICP Exercise 1.39

(load "~/.schemerc.scm")

(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
      x
      (- (square x))))
  (define (d i)
    (+ 1 (* 2 (- i 1))))
  (cont-frac n d k))
