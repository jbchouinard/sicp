; Arithmetic Common
(require "sicp.generic")

; For printing
(define print-precision 4)

(define (round-decimals x n)
  (let ((k (expt 10.0 n)))
    (/ (round (* x k)) k)))

(define (print x)
  (apply-generic 'print (list x)))

(define scheme-add +)
(define scheme-mul *)
(define scheme-sub -)
(define scheme-div /)

(define (+ . ns)
  (define (add x y) (apply-generic 'add (list x y)))
  (cond
    ((null? ns) 0)
    (else
      (fold-left add (car ns) (cdr ns)))))

(define (* . ns)
  (define (mul x y) (apply-generic 'mul (list x y)))
  (cond
    ((null? ns) 1)
    (else
      (fold-left mul (car ns) (cdr ns)))))

(define (- n . ns)
  (define (neg x) (apply-generic 'neg (list x)))
  (define (sub x y) (apply-generic 'sub (list x y)))
  (if (null? ns)
    (neg n)
    (fold-left sub n ns)))

(define (/ n . ns)
  (define (recip x) (apply-generic 'recip (list x)))
  (define (div x y) (apply-generic 'div (list x y)))
  (if (null? ns)
    (recip n)
    (fold-left div n ns)))


(define (make-scheme-number n)
  (make-generic 'make 'scheme-number (list n)))

((lambda () ; Install scheme number operations
  ; Implementation
  (define (tag item) item)
  ; Interface
  (put 'make 'scheme-number (lambda (x) (x)))
  (put 'neg '(scheme-number)
    (lambda (x) (tag (scheme-sub x))))
  (put 'recip '(scheme-number)
    (lambda (x) (tag (scheme-div x))))
  (put 'add '(scheme-number scheme-number)
    (lambda (x y) (tag (scheme-add x y))))
  (put 'sub '(scheme-number scheme-number)
    (lambda (x y) (tag (scheme-sub x y))))
  (put 'sub '(scheme-number)
    (lambda (x) (tag (scheme-sub x))))
  (put 'mul '(scheme-number scheme-number)
    (lambda (x y) (tag (scheme-mul x y))))
  (put 'div '(scheme-number scheme-number)
    (lambda (x y) (tag (scheme-div x y))))
  (put 'print '(scheme-number) display)
  'done))
