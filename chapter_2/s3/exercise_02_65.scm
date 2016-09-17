; SICP Exercise 2.65

(load "~/.schemerc.scm")

(load-module "sicp.set-binary-tree")
(define (reload) (load "exercise_02_65.scm"))
(define (load-next) (load "exercise_02_66.scm"))


(define (union-set s1 s2)
  (define (union-iter sin1 sin2 sout)
    (cond ((null? sin1) (append (reverse sin2) sout))
          ((null? sin2) (append (reverse sin1) sout))
          ((= (car sin1) (car sin2)) (union-iter (cdr sin1) (cdr sin2) (cons (car sin1) sout)))
          ((< (car sin1) (car sin2)) (union-iter (cdr sin1) sin2 (cons (car sin1) sout)))
          ((> (car sin1) (car sin2)) (union-iter sin1 (cdr sin2) (cons (car sin2) sout)))
          (else (error "invalid set -- UNION-SET" s1 s2))))
  (list->tree (reverse (union-iter (tree->list s1) (tree->list s2) empty-set))))

; As previously established, list->tree is O(n), tree->list is O(n), and union-iter
; (based on the union-set procedure of the ordered list representation) is O(n).
; Here we are calling them each a constant number of times, so the resulting procedure
; will also be O(n).
