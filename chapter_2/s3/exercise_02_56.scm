; SICP Exercise 2.56



(define (exponentiation? x)
 (and (pair? x) (eq? (car x) '**)))

(define base cadr)

(define exponent caddr)

(define (make-exponentiation b n)
  (cond ((=number? n 0) 1)
        ((=number? n 1) b)
        ((=number? b 1) 1)
        ((=number? b 0) 0)
        ((and (number? b) (number? n)) (expt b n))
        (else (list '** b n))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
          (make-product
            (exponent exp)
            (make-product
              (make-exponentiation
                (base exp)
                (make-sum (exponent exp) -1))
              (deriv (base exp) var))))
        (else
         (error "unknown expression type -- DERIV" exp))))
