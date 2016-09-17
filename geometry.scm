; SICP Geometry Package

(load "~/.schemerc.scm")

; Points
(define (make-point x y)
  (cons x y))

(define (x-point pt)
  (car pt))

(define (y-point pt)
  (cdr pt))

(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


; Segments
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

(define (x-diff-segment seg)
  (let ((start-x (x-point (start-segment seg)))
        (end-x (x-point (end-segment seg))))
    (abs (- start-x end-x))))

(define (y-diff-segment seg)
  (let ((start-y (y-point (start-segment seg)))
        (end-y (y-point (end-segment seg))))
    (abs (- start-y end-y))))

(define (length-segment seg)
    (sqrt (+ (square (x-diff-segment seg)) (square (y-diff-segment seg)))))


; Rectangles
(define (make-rect segment length)
  (cons segment length))

(define (width-rect rect)
  (let ((side1 (cdr rect))
        (side2 (length-segment (car rect))))
    (if (> side1 side2)
      side2
      side1)))

(define (length-rect rect)
  (let ((side1 (cdr rect))
        (side2 (length-segment (car rect))))
    (if (> side1 side2)
      side1
      side2)))

(define (area-rect rect)
  (* (width-rect rect) (length-rect rect)))

(define (perimeter-rect rect)
 (* 2 (+ (width-rect rect) (length-rect rect))))
