; SICP Exercise 2.59

(load "~/.schemerc.scm")

(define (reload) (load "exercise_02_59.scm"))
(define (load-next) (load "exercise_02_60.scm"))

(load-module "sicp.set-unordered")

(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        ((element-of-set? (car s1) s2) (union-set (cdr s1) s2))
        (else (union-set (cdr s1) (adjoin-set (car s1) s2)))))
