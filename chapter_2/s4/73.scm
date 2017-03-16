; SICP Exercise 2.73

(load-module "sicp.table")

(define opstable (make-table))
(define put (table-make-put opstable))
(define get (table-make-get opstable))

(define variable? symbol?)
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp) var))))
; a. To assimilate the number and variable types into the dispatch, we would
; have to give them type tags. Thus we'd have to use our own number and var
; types instead of the plain built-in ones (e.g. ('number 35) instead of 35.

; d. We would just need to change the order of the arguments in the calls
; to put in the interface definitions.

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (install-deriv-base)
  ; Implementation
  (define (make-sum s1 s2)
    (list '+ s1 s2))
  (define (deriv-sum summands var)
    (let ((s1 (car summands))
          (s2 (cadr summands)))
      (make-sum (deriv s1 var) (deriv s2 var))))
  (define (make-product f1 f2)
    (list '* f1 f2))
  (define (deriv-product factors var)
    (let ((f1 (car factors))
          (f2 (cadr factors)))
      (make-sum
        (make-product f1 (deriv f2 var))
        (make-product (deriv f1 var) f2))))
  (define (make-exponent base power)
    (list '^ base power))
  (define (deriv-expnt expnt var)
    (let ((base (car expnt))
	  (power (cadr expnt)))
      (make-product (make-product power (deriv base var))
		    (make-exponent base (- power 1)))))
  ; Interface
  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  (put 'deriv '^ deriv-expnt)
  'done)

(define (install-deriv-simplify)
  ; Implementation
  (define (product? x)
    (and (pair? x) (eq? (car x) '*)))
  (define (sum? x)
    (and (pair? x) (eq? (car x) '+)))
  (define (make-sum . ss)
    (define (make-sum-iter nums syms rest)
      (if (null? rest)
        (let ((numsum (apply + nums)))
          (cond ((null? syms) numsum)
                ((and (= 0 numsum) (= 1 (length syms))) (car syms))
                ((= 0 numsum) (cons '+ syms))
                (else (append (list '+ numsum) syms))))
        (let ((head (car rest))
              (tail (cdr rest)))
          (cond
            ((number? head) (make-sum-iter (cons head nums) syms tail))
            ((sum? head) (make-sum-iter nums syms (append tail (cdr head))))
            (else (make-sum-iter nums (cons head syms) tail))))))
    (make-sum-iter '() '() ss))
  (define (deriv-sum summands var)
    (let* ((s1 (car summands))
          (rest (cdr summands))
          (s2 (if (null? (cdr rest))
                  (car rest)
                  (apply make-sum rest))))
      (make-sum (deriv s1 var) (deriv s2 var))))
  (define (make-product . ss)
    (define (make-product-iter nums syms rest)
      (if (null? rest)
        (let ((numprod (apply * nums)))
          (cond ((null? syms) numprod)
                ((= 0 numprod) 0)
                ((and (= 1 numprod) (= 1 (length syms))) (car syms))
                ((= 1 numprod) (cons '* syms))
                (else (append (list '* numprod) syms))))
        (let ((head (car rest))
              (tail (cdr rest)))
          (cond
            ((number? head) (make-product-iter (cons head nums) syms tail))
            ((product? head) (make-product-iter nums syms (append tail (cdr head))))
            (else (make-product-iter nums (cons head syms) tail))))))
    (make-product-iter '() '() ss))
  (define (deriv-product factors var)
    (let* ((f1 (car factors))
          (rest (cdr factors))
          (f2 (if (null? (cdr rest))
                  (car rest)
                  (apply make-product rest))))
      (make-sum
        (make-product f1 (deriv f2 var))
        (make-product (deriv f1 var) f2))))
  ; Interface
  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  'done)
