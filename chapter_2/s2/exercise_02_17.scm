; SICP Exercise 2.17

(load "~/.schemerc.scm")

(define (last-pair lst)
  (if (null? (cdr lst))
    lst
    (last-pair (cdr lst))))
