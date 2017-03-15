; SICP Interval Arithmetic Package



(load-module "sicp.math")

(define (sub x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (add x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div x y)
  (if (= 0 (width y))
    (error "division by zero"))
    (mul x
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

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (let ((w (/ (* c p) 100)))
    (make-interval (- c w) (+ c w))))

(define (percent-tolerance interval)
  (* 100 (/ (width interval) (center interval))))

(define (round-decimals x n)
  (let ((k (expt 10.0 n)))
    (/ (round (* x k)) k)))

(define print-precision 4)

(define (print-center-percent interval)
  (display (round-decimals (center interval) print-precision))
  (display " +/- ")
  (display (round-decimals (percent-tolerance interval) print-precision))
  (display "%"))
