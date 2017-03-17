; Arithmetic Package
(load-module "sicp.table")

(define opstable (make-table))
(define put (table-make-put opstable))
(define get (table-make-get opstable))

(define (get-tag item)
  (car item))

(define (get-content item)
  (cdr item))

(define (attach-tag tag content)
  (cons tag content))

(define (apply-generic op . args)
  (let ((types (map get-tag args))
        (vals (map get-content args)))
    (let ((func (get op types)))
      (if (eq? false func)
        (error "not implemented -- APPLY-GENERIC" op types)
        (apply func vals)))))

(define (make-generic type . args)
  (let ((func (get 'make type)))
    (if (eq? false func)
      (error "not implemented -- MAKE-GENERIC" type)
      (apply func args))))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (make-scheme-number n)
  (make-generic 'scheme-number n))
(define (make-rational n d)
  (make-generic 'rational n d))

(define (install-scheme-number)
  ; Implementation
  (define (tag item) (attach-tag 'scheme-number item))
  ; Interface
  (put 'add '(scheme-number scheme-number)
    (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
    (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
    (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
    (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number (lambda (x) (tag x)))
  'done)

