; SICP Exercise 2.20

(load "~/.schemerc.scm")

(define (filter pred? lst)
  (define (make-lst llst rlst)
    (if (null? llst)
      (reverse rlst)
      (let ((next (car llst)))
        (if (pred? next)
          (make-lst (cdr llst) (cons next rlst))
          (make-lst (cdr llst) rlst)))))
  (make-lst lst (list)))

(define (even? n)
  (= 0 (remainder n 2)))

(define (odd? n)
  (not (even? n)))

(define (same-parity? n m)
  (even? (+ n m)))

(define (same-parity n . ns)
  (cons n (filter (lambda (x) (same-parity? n x)) ns)))
