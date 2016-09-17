; SICP Exercise 2.38

(load "~/.schemerc.scm")

; Accumulate as defined in s2.2.3 applies the operator recursively on the list,
; so the values are accumulated from right to left.

; You'll get:
; (op (car sequence) (op (cdar sequence) (op (cddar sequence) ... (op (cd...dar sequence))...))))

; We can define a 'left-accumulate', which applies the operator on the
; leftmost value of the list first:
(define (laccumulate op initial sequence)
  (define (acc-iter acc seq)
    (if (null? seq)
      acc
      (acc-iter (op acc (car seq)) (cdr seq))))
  (acc-iter initial sequence))


; You'll get:
; (op (cd...dar sequence) ... (op (cddar sequence) (op (cdar seqence) (op (car seq)))...)
; (The actual process in Scheme wont look like that since it is iterative, this is just
; for the purpose of comparing the order of application with accumulate)

; For some procedures, like length, laccumulate can be used instead
; without changing the procedure:
(define (left-length sequence)
  (laccumulate (lambda (x y) (+ y 1)) 0 sequence))

; Others not so much; in particular, using laccumulate with the cons
; operator will reverse the sequence.

; Which suggests a new definition for re2verse:

(define (reverse seq)
  (laccumulate cons nil seq))

; In general, using left- or right-accumulate will not make a difference
; if the operator is commutative. It may or may not make a difference for
; non-commutative operators. (Moving operands doesn't *always* change the
; result of non-commutative operations, for example, exponentiation is
; non-commutative, but it so happens that 2^4 = 4^2.)

;(fold-right / 1 (list 1 2 3))
;  3 / 2
;(fold-left / 1 (list 1 2 3))
;  1 / 6
;(fold-right list nil (list 1 2 3))
; (1 (2 (3 ()))
;(fold-left list nil (list 1 2 3))
; (((() 1) 2) 3)
