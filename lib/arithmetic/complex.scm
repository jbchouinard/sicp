(require "schemerc")
(require "sicp.arithmetic.common")

(define (make-complex-from-real-imag r i)
  (make-generic 'make-from-real-imag 'complex (list r i)))

(define (make-complex-from-mag-ang r a)
  (make-generic 'make-from-mag-ang 'complex (list r a)))

((lambda () ; Install complex package
   ; Implementation
   (define (tag item) (attach-tag 'complex item))
   (define (make-from-real-imag r i)
     (make-generic 'make-from-real-imag 'rectangular (list r i)))
   (define (make-from-mag-ang r a)
     (make-generic 'make-from-mag-ang 'polar (list r a)))
   (define (real-part c)
     (apply-generic 'real-part (list c)))
   (define (imag-part c)
     (apply-generic 'imag-part (list c)))
   (define (magnitude c)
     (apply-generic 'magnitude (list c)))
   (define (angle c)
     (apply-generic 'angle (list c)))
   (define (neg-complex c)
     (make-from-real-imag (- (real-part c)) (- (imag-part c))))
   (define (recip-complex c)
     (let ((dnm (expt (magnitude  c) 2)))
       (make-from-real-imag (/ (real-part c) dnm)
                            (- (/ (imag-part c) dnm)))))
   (define (add-complex c1 c2)
     (make-from-real-imag (+ (real-part c1) (real-part c2))
                          (+ (imag-part c1) (imag-part c2))))
   (define (sub-complex c1 c2)
     (make-from-real-imag (- (real-part c1) (real-part c2))
                          (- (imag-part c1) (imag-part c2))))
   (define (mul-complex c1 c2)
     (make-from-real-imag (- (* (real-part c1) (real-part c2))
                             (* (imag-part c1) (imag-part c2)))
                          (+ (* (real-part c1) (imag-part c2))
                             (* (imag-part c1) (real-part c2)))))
   (define (div-complex c1 c2)
     (mul-complex c1 (recip-complex c2)))
   (define (print-complex c)
     (let ((a (real-part c))
           (b (imag-part c)))
       (print a)
       (if (< b 0)
         (display " - ")
         (display " + "))
       (print (abs b))
       (display "i")))
   ; Interface
   (put 'make-from-real-imag 'complex
     (lambda (r i) (tag (make-from-real-imag r i))))
   (put 'make-from-mag-ang 'complex
     (lambda (r a) (tag (make-from-mag-ang r a))))
   (put 'real-part '(complex) real-part)
   (put 'imag-part '(complex) imag-part)
   (put 'magnitude '(complex) magnitude)
   (put 'angle '(complex) angle)
   (put 'neg '(complex)
     (lambda (c) (tag (neg-complex c))))
   (put 'recip '(complex)
     (lambda (c) (tag (recip-complex c))))
   (put 'add '(complex complex)
     (lambda (c1 c2) (tag (add-complex c1 c2))))
   (put 'sub '(complex complex)
     (lambda (c1 c2) (tag (sub-complex c1 c2))))
   (put 'mul '(complex complex)
     (lambda (c1 c2) (tag (mul-complex c1 c2))))
   (put 'div '(complex complex)
     (lambda (c1 c2) (tag (div-complex c1 c2))))
   (put 'print '(complex) print-complex)
   'done))

((lambda () ; Install complex rectangular package
  ; Implementation
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ; Interface
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done))

 ((lambda (); Install complex polar package
  ; Implementation
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ; Interface
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done))
