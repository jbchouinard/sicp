; SICP Exercise 1.36

(load "~/.schemerc.scm")

; Modify fixed-point so that it prints the sequence of approximations it generates,
; using the newline and display primitives shown in exercise 1.22. Then find a solution
; to x^x = 1000 by finding a fixed point of x   log(1000)/log(x). (Use Scheme's primitive
; log procedure, which computes natural logarithms.) Compare the number of steps this
; takes with and without average damping. (Note that you cannot start fixed-point with
; a guess of 1, as this would cause division by log(1) = 0.)

(define (fixed-point-verbose f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display guess)
      (newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (fixed-point-damped-verbose f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
     (display guess)
     (newline)
     (if (close-enough? guess next)
        next
        (try (average guess next)))))
  (try first-guess))

(define tolerance 0.00001)

(define (f x)
    (/ (log 1000) (log x)))

(define (solution1)
  (fixed-point-verbose f 2.0))
; Took 34 steps

(define (solution2)
  (fixed-point-damped-verbose f 2.0))
; Took 10 steps
