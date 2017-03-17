; Rational Arithmetic

(require "schemerc")
(require "sicp.arithmetic.common")

(define (make-rational . args)
  (make-generic 'make 'rational args))

((lambda () ; Install rational number operations
  ; Implementation
  (define (tag item) (attach-tag 'rational item))
  (define (make-rat num dnm)
    (if (= dnm 0)
      (error "division by zero -- MAKE-RAT" num dnm)
      (let ((d (gcd num dnm)))
        (cons (/ num d) (/ dnm d)))))
  (define (make-rat-poly args)
    (cond ((= (length args) 1) (make-rat (car args) 1))
          ((= (length args) 2) (make-rat (car args) (cadr args)))
          (else (error "wrong number of args -- MAKE-RAT-POLY" args))))
  (define num car)  ; get numerator
  (define dnm cdr)  ; get denominator
  (define (equ?-rat r1 r2)
    (and (= (num r1) (num r2))
         (= (dnm r1) (dnm r2))))
  (define (zero?-rat r)
    (= 0 (num r)))
  (define (neg-rat r) (make-rat (- (num r)) (dnm r)))
  (define (recip-rat r) (make-rat (dnm r) (num r)))
  (define (add-rat r1 r2)
    (if (= (dnm r1) (dnm r2))
        (make-rat (+ (num r1) (num r2)) (dnm r1))
        (make-rat (+ (* (num r1) (dnm r2))
                     (* (num r2) (dnm r1)))
                  (* (dnm r1) (dnm r2)))))
  (define (sub-rat r1 r2)
    (add-rat r1 (neg-rat r2)))
  (define (mul-rat r1 r2)
    (make-rat (* (num r1) (num r2))
              (* (dnm r1) (dnm r2))))
  (define (div-rat r1 r2)
    (mul-rat r1 (recip-rat r2)))
  (define (print-rat r)
    (print (num r))
    (display "/")
    (print (dnm r)))
  ; Interface
  (put 'make 'rational
    (lambda args (tag (make-rat-poly args))))
  (put 'equ? '(rational rational) equ?-rat)
  (put 'zero? '(rational) zero?-rat)
  (put 'neg '(rational)
    (lambda (r) (tag (neg-rat r))))
  (put 'recip '(rational)
    (lambda (r) (tag (recip-rat r))))
  (put 'add '(rational rational)
    (lambda (r1 r2) (tag (add-rat r1 r2))))
  (put 'sub '(rational rational)
    (lambda (r1 r2) (tag (sub-rat r1 r2))))
  (put 'mul '(rational rational)
    (lambda (r1 r2) (tag (mul-rat r1 r2))))
  (put 'div '(rational rational)
    (lambda (r1 r2) (tag (div-rat r1 r2))))
  (put 'print '(rational) print-rat)
  'done))
