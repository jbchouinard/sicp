; SICP Exercise 2.6

(load "~/.schemerc.scm")

; In case representing pairs as procedures wasn't mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;This representation is known as Church numerals, after its inventor, Alonzo Church, the logician who invented the  calculus.

; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to evaluate (add-1 zero)). Give a direct definition of the addition procedure + (not in terms of repeated application of add-1).

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (plus n1 n2)
  (lambda (f) (lambda (x) ((n1 f) ((n2 f) x)))))

; Just for fun: convert Church numerals to integers
(define (inc n) (+ 1 n))

(define (to-integer f)
  ((f inc) 0))
