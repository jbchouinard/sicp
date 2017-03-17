; SICP Base Symbolic Algebra Package



; ------------------------- Helper Procedures -------------------------

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


; ------------------------- Algebraic Expressions -------------------------
; Common symbolic algebra procedures

(define (variable? x) (symbol? x))

(define (=number? a1 a2)
  (and (number? a1) (number? a2) (= a1 a2)))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))


; ------------------------- Symbolic Differentiation -------------------------

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (if debug
           (begin
             (newline)
             (display "applying sum rule on: ")
             (display exp)
             (display " with respect to ")
             (display var)))
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (if debug
           (begin
             (newline)
             (display "applying product rule on: ")
             (display exp)
             (display " with respect to ")
             (display var)))
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
          (if debug
            (begin
              (newline)
              (display "applying exponent rule on: ")
              (display exp)
              (display " with respect to ")
              (display var)))
          (make-product
            (exponent exp)
            (make-product
              (make-exponentiation
                (base exp)
                (make-sum (exponent exp) -1)))))
        (else
         (error "unknown expression type -- DERIV" exp))))
