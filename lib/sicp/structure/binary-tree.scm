(require "schemerc")

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (fold-right + 0 (map (lambda (x) 1) (enumerate-tree t))))

(define (tree-map f tree)
 (define (tree-map-inner tr)
  (cond ((null? tr) nil)
        ((not (pair? tr)) (f tr))
        (else (map tree-map-inner tr))))
  (tree-map-inner tree))
