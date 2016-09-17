; SICP Exercise 2.30

(load "~/.schemerc.scm")

; Square-tree directly
(define nil (list))

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree)) (square-tree (cdr tree))))))

; Square-tree using map and recursion

(define (square-tree-2 tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (square tree))
        (else (map square-tree tree))))

; Tests

(define my-tree (cons (cons 5
                            (cons 4
                                  (cons 5 4)))
                      (cons (cons 1 2)
                            (cons 1 2))))

(define my-tree-2 (list 3 4 (list 1 (list 3 4 5 6))))
