; SICP Exercise 1.45



; We saw in section 1.3.3 that attempting to compute square roots by naively finding a fixed point of y  x/y does not converge, and that this can be fixed by average damping. The same method works for finding cube roots as fixed points of the average-damped y  x/y2. Unfortunately, the process does not work for fourth roots -- a single average damp is not enough to make a fixed-point search for y  x/y3 converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of y  x/y3) the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute nth roots as a fixed-point search based upon repeated average damping of y  x/yn-1. Use this to implement a simple procedure for computing nth roots using fixed-point, average-damp, and the repeated procedure of exercise 1.43. Assume that any arithmetic operations you need are available as primitives.

; nth root    number of damps   expt of y
; 2 (sqrt)    1                 1
; 3 (cbrt)    1                 2
; 4           2                 3
; 5           2                 4
; 6           2                 (- n 1)...
; 7           2
; 8           3
; 15          3
; 16          4

(define (log2trunc x) (floor (/ (log x) (log 2))))

(define (nth-root x n)
  (define f (lambda (y) (/ x (expt y (- n 1)))))
  (fixed-point ((repeated average-damp (log2trunc n)) f) 1.0))
