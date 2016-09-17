; SICP Exercise 1.29

(load "~/.schemerc.scm")

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b))))

(define (integral f a b n)
    (define (dx) (/ (- b a) n))
    (define (add-dx x) (+ x (dx)))
    (* (sum f (+ a (/ (dx) 2.0)) add-dx b) (dx)))

(define (simpson-integral f a b n)
    (define (h) (/ (- b a) n))
    (define (coeff k)
        (cond ((= k 0) 1.0)
              ((= k n) 1.0)
              (else (+ 2.0 (* 2.0 (modulo k 2))))))
    (define (simpson-term k)
        (* (coeff k) (f (+ a (* k (h))))))
    (define (simpson-next k)
        (+ 1 k))
    (* (/ (h) 3.0) (sum simpson-term 0 simpson-next n)))

(define (cube x) (* x x x))

; (integral cube 0 1 100)
; $1 = 0.24998750000000042

; (integral cube 0 1 1000)
; $2 = 0.249999875000001

; (simpson-integral cube 0 1 100)
; $3 = 0.24999999999999992

; (simpson-integral cube 0 1 1000)
; $1 = 0.2500000000000002
