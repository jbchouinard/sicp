; SICP Exercise 2.18



(define (reverse lst)
  (define (reverse-iter llst rlst)
    (if (null? llst)
      rlst
      (reverse-iter (cdr llst) (cons (car llst) rlst))))
  (reverse-iter lst (list)))
