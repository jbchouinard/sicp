; SICP Exercise 2.62

(require "sicp.structure.set-ordered")

(define (reload) (load "exercise_02_62.scm"))
(define (load-next) (load "exercise_02_63.scm"))


(define (union-set s1 s2)
  (define (union-iter sin1 sin2 sout)
    (cond ((null? sin1) (append (reverse sin2) sout))
          ((null? sin2) (append (reverse sin1) sout))
          ((= (car sin1) (car sin2)) (union-iter (cdr sin1) (cdr sin2) (cons (car sin1) sout)))
          ((< (car sin1) (car sin2)) (union-iter (cdr sin1) sin2 (cons (car sin1) sout)))
          ((> (car sin1) (car sin2)) (union-iter sin1 (cdr sin2) (cons (car sin2) sout)))
          (else (error "invalid set -- UNION-SET" s1 s2))))
  (reverse (union-iter s1 s2 empty-set)))
