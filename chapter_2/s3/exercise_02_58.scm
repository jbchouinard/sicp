; SICP Exercise 2.58

(require "sicp.deriv.symbolic-common")

; a. Infix notation, binary operators
(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define addend car)

(define augend caddr)

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (product? x)
 (and (pair? x) (eq? (cadr x) '*)))

(define multiplier car)

(define multiplicand caddr)

(define (make-product a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (* a1 a2))
        (else (list a1 '* a2))))

; b. Infix notation, n-ary operators

; Returns the part of the list x starting at item
; or #f if item is not in the list
(define (memq item x)
  (cond ((null? x) false)
        ((not (pair? x)) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

; Returns the part of the list x up to and including
; item or #f if item is not in the list
(define (lmemq item x)
  (append (lxmemq item x) (list item)))

; Like memq, but excludes the searched item
(define (xmemq item x)
  (cdr (memq item x)))

(define (lxmemq item x)
  (define (lxmemq-iter left rest)
    (cond ((null? rest) false)
          ((eq? item (car rest)) (reverse left))
          (else (lxmemq-iter (cons (car rest) left) (cdr rest)))))
    (lxmemq-iter '() x))

(define (sum? x)
  (not (eq? #f (memq '+ x))))

(define (addend x)
  (if (not (sum? x))
    (error "this is not a sum expression")
    (let ((ret (lxmemq '+ x)))
      (if (= 1 (length ret)) (car ret) ret))))

(define (augend x)
  (if (not (sum? x))
    (error "this is not a sum expression")
    (let ((ret (xmemq '+ x)))
      (if (= 1 (length ret)) (car ret) ret))))

(define (sum-add-atom atom atoms)
  (cond ((null? atoms) atom)
        ((not (sum? atoms)) (list atom '+ atoms))
        (else (cons atom (cons '+ atoms)))))

(define (make-sum . x)
  (if debug
    (begin
      (newline)
      (display "calling make-sum on ")
      (display x)))
  (define (smp-iter num atoms rest)
    (if (null? rest)
      (cond ((null? atoms) num)
            ((= num 0) atoms)
            (else (sum-add-atom num atoms)))
      (let ((head (car rest))
            (tail (cdr rest)))
        (cond ((eq? '+ head) (smp-iter num atoms tail))
              ((number? head) (smp-iter (+ num head) atoms tail))
              ((sum? head) (smp-iter num atoms (cons (augend head) (cons (addend head) tail))))
              ((product? head) (let ((new-head (make-product head)))
                (if (equal? head new-head)
                    (smp-iter num (sum-add-atom head atoms) tail)
                    (smp-iter num atoms (cons new-head tail)))))
              (else (smp-iter num (sum-add-atom head atoms) tail))))))
    (smp-iter 0 '() x))

(define (product? x)
  (and (not (sum? x)))
    (not (eq? #f (memq '* x))))

(define (multiplier m)
  (if (not (product? m))
      (error "this is not a product expression")
      (let ((ret (lxmemq '* m)))
        (if (= 1 (length ret)) (car ret) ret))))

(define (multiplicand m)
  (if (not (product? m))
      (error "this is not a product expression")
      (let ((ret (xmemq '* m)))
        (if (= 1 (length ret)) (car ret) ret))))

(define (product-add-atom atom atoms)
  (cond ((null? atoms) atom)
        ((not (product? atoms)) (list atom '* atoms))
        (else (cons atom (cons '* atoms)))))

(define (make-product . x)
  (if debug
    (begin
      (newline)
      (display "calling make-product on ")
      (display x)))
  (define (smp-iter num atoms rest)
    (if (null? rest)
      (cond ((null? atoms) num)
            ((= num 0) 0)
            ((= num 1) atoms)
            (else (product-add-atom num atoms)))
      (let ((head (car rest))
            (tail (cdr rest)))
        (cond ((eq? '* head) (smp-iter num atoms tail))
              ((number? head) (smp-iter (* num head) atoms tail))
              ((product? head) (smp-iter num atoms (cons (multiplicand head)
                                                         (cons (multiplier head) tail))))
              ((sum? head) (let ((new-head (make-sum head)))
                (if (equal? head new-head)
                    (smp-iter num (product-add-atom head atoms) tail)
                    (smp-iter num atoms (cons new-head tail)))))
              (else (smp-iter num (product-add-atom head atoms) tail))))))
    (smp-iter 1 '() x))

(define (exponentiation? x)
 (and (pair? x)
      (not (sum? x))
      (not (product? x))
      (eq? (cadr x) '**)))

(define (base x)
  (if (not (exponentiation? x))
      (error "this is not an exponent expression")
      (car x)))

(define (exponent x)
  (if (not (exponentiation? x))
      (error "this is not an exponent expression")
      (caddr x)))

(define (make-exponentiation b n)
  (if debug
    (begin
      (newline)
      (display "calling make-exponentiation on ")
      (display (list b n))))
  (cond ((=number? n 0) 1)
        ((=number? b 0) 0)
        ((=number? n 1) b)
        ((=number? b 1) 1)
        ((and (number? b) (number? n)) (expt b n))
        (else (list b '** n))))
