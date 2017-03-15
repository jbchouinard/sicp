; ------------------------- Symbolic Package - Prefix Notation -------------------------



(load-module "sicp.symbolic-common")

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define addend cadr)

(define (augend a) (apply make-sum (cddr a)))

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

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define multiplier cadr)

(define (multiplicand m) (apply make-product (cddr m)))

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

(define (exponentiation? x)
 (and (pair? x) (eq? (car x) '**)))

(define base cadr)

(define exponent caddr)

(define (make-exponentiation b n)
  (cond ((=number? n 0) 1)
        ((=number? b 0) 0)
        ((and (number? b) (number? n)) (expt b n))
        (else (list '** b n))))
