; SICP Exercise 2.48

(load "~/.schemerc.scm")

(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))
