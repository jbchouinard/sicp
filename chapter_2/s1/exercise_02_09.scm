; SICP Exercise 2.9



(define (width-interval x)
  (/ (- (upper-bound x) (lower-bound x)) 2))

(define a (make-interval 1 3))
(define b (make-interval 8 10))

; Let x be the center of the interval X = (x1, x2), x2>=x1, with width dx = (x2 - x1) / 2
; Let y be the center of the interval Y = (y1, y2), y2>=y1, with width dy = (y2 - y1) / 2
; Then x1 = x - dx, x2 = x + dx, y1 = y - dy, y2 = y + dy

; Let Z = X + Y
; Then Z = (x - dx + y - dy, x + dx + y + dy)
; dz = ((x + dx + y + dy) - (x - dx + y - dy)) / 2 = (dx + dy)
; The width of the sum of intervals is only a function of the width of the operands

(= (width-interval (add-interval a b)) (width-interval (add-interval a a)))
; True

; Let Z = X * Y
; Then Z = ((x-dx)*(y-dy), (x+dx)*(y+dy))
;        = (xy - xdy - ydx + dydx, xy + xdy + ydx + dxdy)
; Then dz = ((xy + xdy + ydx + dxdy) - (xy - xdy - ydx + dydx)) / 2
;         = xdy + ydx
; That is, the width of the product of intervals is NOT only a function of the width of the operands

(= (width-interval (mul-interval a b)) (width-interval (mul-interval a a)))
; False

; Copied
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))

(define (upper-bound z)
  (let ((a (car z))
        (b (cdr z)))
    (if (> a b) a b)))

(define (lower-bound z)
  (let ((a (car z))
        (b (cdr z)))
    (if (> a b) b a)))

