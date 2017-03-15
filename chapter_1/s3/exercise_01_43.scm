; SICP Exercise 1.43



;  If f is a numerical function and n is a positive integer, then we can form the nth repeated application of f, which is defined to be the function whose value at x is f(f(...(f(x))...)). For example, if f is the function x   x + 1, then the nth repeated application of f is the function x   x + n. If f is the operation of squaring a number, then the nth repeated application of f is the function that raises its argument to the 2nth power. Write a procedure that takes as inputs a procedure that computes f and a positive integer n and returns the procedure that computes the nth repeated application of f. Your procedure should be able to be used as follows:
;
; ((repeated square 2) 5)
; 625
;
; Hint: You may find it convenient to use compose from exercise 1.42.

; Recursive definition
(define (repeated-rec f n)
  (if (= n 1)
    f
    (compose f (repeated-rec f (- n 1)))))

; Fast(?) recursive definition
(define (repeated-rec-fast f n)
  (cond
    ((= n 1) f)
    ((= 0 (remainder n 2)) (repeated-rec (compose f f) (/ n 2)))
    (else (compose f (repeated-rec f (- n 1))))))

; Iterative definition
(define (repeated-iter f n)
  (define (iter g n)
    (if (= n 1)
      g
      (iter (compose f g) (- n 1))))
  (iter f n))
