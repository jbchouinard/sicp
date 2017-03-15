; SICP Exercise 2.17



(define (last-pair lst)
  (if (null? (cdr lst))
    lst
    (last-pair (cdr lst))))
