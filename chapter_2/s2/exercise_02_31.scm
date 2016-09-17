; SICP Exercise 2.31

(load "~/.schemerc.scm")

(define nil (list))

(define (tree-map f tree)
 (define (tree-map-inner tr)
  (cond ((null? tr) nil)
        ((not (pair? tr)) (f tr))
        (else (map tree-map-inner tr))))
  (tree-map-inner tree))

(define (square-tree tree) (tree-map square tree))

(define my-tree (list 3 4 (list 1 (list 3 4 5 6))))
