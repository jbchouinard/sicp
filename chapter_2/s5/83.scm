; SICP Exercise 2.83

(require "sicp.generic")

((lambda ()
   ; Implementation
   (define (raise-integer n)
     (make-rational n 1))
   (define (raise-rational q)
     (make-real (/ (num q) (dnm q))))
   (define (raise-real r)
     (make-complex-from-real-imag r 0))
   ; Interface
   (put 'raise 'integer raise-integer)
   (put 'raise 'rational raise-rational)
   (put 'raise 'real raise-real)
   'done))

(define (raise x)
  (make-generic 'raise (get-tag x) (get-content x)))
