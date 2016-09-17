; SICP Exercise 1.35

(load "~/.schemerc.scm")

(define tolerance 0.0000001)

(define (fixed-point-damped f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
     (if (close-enough? guess next)
        next
        (try (average guess next)))))
  (try first-guess))

; For fun
; Value: 3.14111328125
(define (pi)
  (half-interval-method sin 2.0 4.0))

(define (sqrt x)
  (define (f y) (/ x y))
  (fixed-point-damped f 2.0))

; Solution
; tolerance = 0.00001
; Value: 1.6180327868852458
; tolerance = 0.0000001
; Value: 1.6180339631667064
; fixed-point-damped
; Value: 1.6180339986053216
(define (golden-ratio)
  (define (f y) (+ 1 (/ 1 y)))
  (fixed-point f 1.0))

