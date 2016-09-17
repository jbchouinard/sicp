; SICP Exercise 2.2

(load "~/.schemerc.scm")

;Consider the problem of representing line segments in a plane. Each segment is represented as a pair of points: a starting point and an ending point. Define a constructor make-segment and selectors start-segment and end-segment that define the representation of segments in terms of points. Furthermore, a point can be represented as a pair of numbers: the x coordinate and the y coordinate. Accordingly, specify a constructor make-point and selectors x-point and y-point that define this representation. Finally, using your selectors and constructors, define a procedure midpoint-segment that takes a line segment as argument and returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints). To try your procedures, you'll need a way to print points:

(define (make-point x y)
  (cons x y))

(define (x-point pt)
  (car pt))

(define (y-point pt)
  (cdr pt))

(define (print-point p)
2  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(define (print-segment seg)
  (display "[")
  (print-point (start-segment seg))
  (display ",")
  (print-point (end-segment seg))
  (display "]"))

(define (midpoint-segment seg)
  (let ((start-x (x-point (start-segment seg)))
        (start-y (y-point (start-segment seg)))
        (end-x (x-point (end-segment seg)))
        (end-y (y-point (end-segment seg))))
    (make-point
      (average start-x end-x)
      (average start-y end-y))))
