; SICP Exercise 2.61

(require "sicp.structure.set-ordered")

(define (reload) (load "exercise_02_61.scm"))
(define (load-next) (load "exercise_02_62.scm"))


(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))
