; SICP Exercise 2.57



; Prefix notation, n-ary operators
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
