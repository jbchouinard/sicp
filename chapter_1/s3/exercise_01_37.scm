; SICP Exercise 1.37

(load "~/.schemerc.scm")

(define (cont-frac n d k)
  (define (cont-frac-rec i)
    (if (> i k)
      0
      (/ (n i) (+ (d i) (cont-frac-rec (+ i 1))))))
  (cont-frac-rec 1))

; Need k=12 to get an estimate that is accurate to 4 decimal places

(define (cont-frac-alt n d k)
  (define (cont-frac-iter i c)
    (if (= i 0)
      c
      (cont-frac-iter (- i 1) (/ (n i) (+ (d i) c)))))
  (cont-frac-iter k 0))
