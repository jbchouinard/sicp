; SICP Exercise 2.23



(define (for-earch f lst)
  (cond ((null? lst) #t)
        (else (f (car lst))
              (for-each f (cdr lst)))))
