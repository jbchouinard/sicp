; SICP Interval Arithmetic Package

(require "schemerc")
(require "sicp.arithmetic.common")


; Arithmetic operations
((lambda ()
  ; Implementation
  (define (tag item) (attach-tag 'interval item))
  (define (make-interval n1 n2) (cons (min n1 n2) (max n1 n2)))
  (define (low ival) (car ival))
  (define (high ival) (cdr ival))
  (define (center ival) (/ (+ (high ival) (low ival)) 2))
  (define (width ival) (- (high ival) (low ival)))
  (define (equ? i1 i2)
    (and (= (low i1) (low i2))
         (= (high i1) (high i2))))
  (define (zero? i1)
    (= 0 (width i1)))
  (define (neg ival)
    (make-interval (- (low ival)) (- (high ival))))
  (define (make-from-center-width c w)
    (make-interval (- c w) (+ c w)))
  (define (recip ival)
    (make-interval (/ 1.0 (high ival))
                   (/ 1.0 (low ival))))
  (define (add x y)
    (make-interval (+ (low x) (low y))
                   (+ (high x) (high y))))
  (define (sub x y)
    (make-interval (- (low x) (high y))
                   (- (high x) (low y))))
  (define (mul x y)
    (let ((p1 (* (low x) (low y)))
          (p2 (* (low x) (high y)))
          (p3 (* (high x) (low y)))
          (p4 (* (high x) (high y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4))))
  (define (div x y)
    (if (= 0 (width y))
      (error "division by zero -- DIV-INTERVAL" x y)
      (mul  x (recip y))))
  (define (print interval)
    (print (round-decimals (center interval) print-precision))
    (display " +/- ")
    (print (round-decimals (/ (width interval) 2) print-precision)))
  ; Interface
  (put 'make-interval 'interval
    (lambda (n1 n2) (tag (make-interval n1 n2))))
  (put 'make-from-center-width 'interval
    (lambda (n1 n2) (tag (make-from-center-width n1 n2))))
  (put 'upper-bound '(interval) high)
  (put 'lower-bound '(interval) low)
  (put 'equ? '(interval interval) equ?)
  (put 'zero? '(interval interval) zero?)
  (put 'neg '(interval)
    (lambda (ival) (tag (neg ival))))
  (put 'recip '(interval)
    (lambda (ival) (tag (recip ival))))
  (put 'add '(interval interval)
    (lambda (x y) (tag (add x y))))
  (put 'sub '(interval interval)
    (lambda (x y) (tag (sub x y))))
  (put 'mul '(interval interval)
    (lambda (x y) (tag (mul x y))))
  (put 'div '(interval interval)
    (lambda (x y) (tag (div x y))))
  (put 'print '(interval) print)
  'done))


; Interval specific operations
(define (make-interval n1 n2)
  (make-generic 'make-interval 'interval (list n1 n2)))

(define (make-interval-from-center-width c w)
  (make-generic 'make-from-center-width 'interval (list c w)))

(define (upper-bound ival)
  (apply-generic 'upper-bound (list ival)))

(define (lower-bound ival)
  (apply-generic 'lower-bound (list ival)))

(define (center ival)
  (apply-generic 'center (list ival)))

(define (width ival)
  (apply-generic 'width (list ival)))

(define (make-interval-from-center-pct c p)
    (make-interval-from-center-width c (* c (/ pct 100))))

(define (percent-tolerance interval)
  (* 100 (/ (width interval) (center interval))))

