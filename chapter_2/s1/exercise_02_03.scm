; SICP Exercise 2.3



; Implement a representation for rectangles in a plane. (Hint: You may want to make use of exercise 2.2.) In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle. Now implement a different representation for rectangles. Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?

; New
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

; Representation as a segment
; Only represents rectangles aligned with x-y axes
; (define (make-rect segment)
;   segment)
;
; (define (width-rect rect)
;   (let ((xlength (x-diff-segment rect))
;         (ylength (y-diff-segment rect)))
;     (if (> xlength ylength)
;       ylength
;       xlength)))
;
; (define (width-rect rect)
;   (let ((xlength (x-diff-segment rect))
;         (ylength (y-diff-segment rect)))
;     (if (> xlength ylength)
;       xlength
;       ylength)))

; Representation as a segment and length
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

(define (midpoint-segment seg)
  (let ((start-x (x-point (start-segment seg)))
        (start-y (y-point (start-segment seg)))
        (end-x (x-point (end-segment seg)))
        (end-y (y-point (end-segment seg))))
    (make-point
      (average start-x end-x)
      (average start-y end-y))))
