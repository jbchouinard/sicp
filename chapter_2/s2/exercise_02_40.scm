; SICP Exercise 2.40

(load "~/.schemerc.scm")

; Generate all unique pairs (i, j) such that 1 <= j < i <= n
(define (unique-pairs n)
  (flatmap (lambda (i) (map (lambda (j) (list i j))
                            (range-1 1 (- i 1))))
           (range-1 1 n)))

(define (make-pair-sum pair)
 (append pair (list (+ (car pair) (cadr pair)))))

(define (prime-sum? lst)
  (prime? (fold-right + 0 lst)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))
