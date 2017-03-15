; SICP Exercise 1.38



(define (n k) 1.0)

(define (d k)
  (if (= (modulo k 3) 2)
    (* (/ (+ 1 k) 3) 2)
    1.0))

(define e (+ 2 (cont-frac n d 100)))
