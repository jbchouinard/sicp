; SICP Exercise 2.12

(load "~/.schemerc.scm")

; Define a constructor make-center-percent that takes a center and a percentage tolerance and produces the desired interval. You must also define a selector percent that produces the percentage tolerance for a given interval. The center selector is the same as the one shown above.

(define (make-center-percent c p)
  (let ((w (/ (* c p) 100)))
    (make-interval (- c w) (+ c w))))

(define (percent-tolerance interval)
  (* 100 (/ (width interval) (center interval))))
