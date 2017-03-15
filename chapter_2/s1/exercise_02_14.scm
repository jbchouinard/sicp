; SICP Exercise 2.14



(define (par1 r1 r2)
  (div (mul r1 r2)
       (add r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div one
         (add (div one r1)
              (div one r2)))))

(define x (make-center-percent 100 10))
(define y (make-center-percent 500 5))

(define (interval-tests a b)
  (display "A: ")
  (print-center-percent a)
  (newline)
  (display "B: ")
  (print-center-percent b)
  (newline)
  (display "A/B: ")
  (print-center-percent (div a b))
  (newline)
  (display "A/A: ")
  (print-center-percent (div a a))
  (newline)
  (display "A*B/B: ")
  (print-center-percent (div (mul a b) b))
  (newline)
  (display "A*A/A: ")
  (print-center-percent (div (mul a a) a))
  (newline)
  (display "PAR1: ")
  (print-center-percent (par1 a b))
  (newline)
  (display "PAR2: ")
  (print-center-percent (par2 a b)))
