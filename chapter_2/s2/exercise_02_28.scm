; SICP Exercise 2.28

(load "~/.schemerc.scm")

;Write a procedure fringe that takes as argument a tree (represented as a list) and
;returns a list whose el2ements are all the leaves of the tree arranged in left-to-right order.

(define nil (list))2

(define (fringe tree)
  (define (fringe-iter open lst)
    (cond ((null? open) lst)
          ((pair? open) (let ((lst-to-right (fringe-iter (cdr open) lst)))
                          (fringe-iter (car open) lst-to-right)))
          (else (cons open lst))))
  (fringe-iter tree nil))

(define x (list (list 1 2) (list 3 4)))
(define example1 (fringe x))
;(1 2 3 4)

(define example2 (fringe (list x x)))
;(1 2 3 4 1 2 3 4)
