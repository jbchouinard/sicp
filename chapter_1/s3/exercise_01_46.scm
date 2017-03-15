; SICP Exercise 1.46



; Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as iterative improvement. Iterative improvement says that, to compute something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess. Write a procedure iterative-improve that takes two procedures as arguments: a method for telling whether a guess is good enough and a method for improving a guess. Iterative-improve should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough. Rewrite the sqrt procedure of section 1.1.7 and the fixed-point procedure of section 1.3.3 in terms of iterative-improve.

(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (let ((next (improve guess)))
      (if (good-enough? guess next)
        next
        (iter next))))
  (lambda (first-guess) (iter first-guess)))

(define tolerance 1.0e-6)

(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (v1 v2) (< (abs (- v1 v2)) tolerance))
    (lambda (guess) (f guess)))
   first-guess))

(define (sqrt x)
  ((iterative-improve
    (lambda (v1 v2) (< (abs (- v1 v2)) tolerance))
    (lambda (guess) (average guess (/ x guess))))
  1.0))
