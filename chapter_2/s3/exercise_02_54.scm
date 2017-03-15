; SICP Exercise 2.54



(define (equal? lst1 lst2)
  (cond ((not (eq? (pair? lst1) (pair? lst2))) #f)
        ((not (pair? lst1)) (eq? lst1 lst2))
        (else (and (equal? (car lst1) (car lst2))
                   (equal? (cdr lst1) (cdr lst2))))))
