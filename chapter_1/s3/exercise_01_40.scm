; SICP Exercise 1.40

(load "~/.schemerc.scm")

; Define a procedure cubic that can be used together with the newtons-method procedure in ; expressions of the form;
;
; (newtons-method (cubic a b c) 1)
;
; to approximate zeros of the cubic x3 + ax2 + bx + c.

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))
