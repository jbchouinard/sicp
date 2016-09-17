; SICP Exercise 2.41

(load "~/.schemerc.scm")

; Write a procedure to find all ordered triples of distinct positive integers i, j, and k less
; than or equal to a given integer n that sum to a given integer s.

(define (unique-triplets m)
  (unique-ntuples 3 m))

(define (unique-ntuples n m)
  (cond
    ((= n 0) (list))
    ((= n 1) (map list (range-1 1 m)))
    (else (flatmap (lambda (i)
                   (map (lambda (j) (cons i j)) (unique-ntuple (- n 1) (- i 1))))
           (range-1 1 m)))))
