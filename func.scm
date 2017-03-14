; Basic Higher Order Functions Package

(load "~/.schemerc.scm")


(define (accumulate combiner null-value term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (combiner result (term a)))))
    (iter a null-value))

(define (filtered-accumulate filter combiner null-value term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (if (filter a)
                (iter (next a) (combiner result (term a)))
                (iter (next a) result))))
    (iter a null-value))

(define (double f)
  (lambda (x)
    (f (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (cond
    ((= n 1) f)
    ((= 0 (remainder n 2)) (repeated (compose f f) (/ n 2)))
    (else (compose f (repeated f (- n 1))))))
