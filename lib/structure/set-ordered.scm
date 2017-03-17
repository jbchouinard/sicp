; SICP Set Package - Ordered List Representation



(define empty-set '())

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

(define (make-set . x)
  (define (make-set-iter set rest)
    (if (null? rest)
        set
        (make-set-iter (adjoin-set (car rest) set) (cdr rest))))
  (make-set-iter empty-set x))

(define (union-set s1 s2)
  (define (union-iter sin1 sin2 sout)
    (cond ((null? sin1) (append (reverse sin2) sout))
          ((null? sin2) (append (reverse sin1) sout))
          ((= (car sin1) (car sin2)) (union-iter (cdr sin1) (cdr sin2) (cons (car sin1) sout)))
          ((< (car sin1) (car sin2)) (union-iter (cdr sin1) sin2 (cons (car sin1) sout)))
          ((> (car sin1) (car sin2)) (union-iter sin1 (cdr sin2) (cons (car sin2) sout)))
          (else (error "invalid set -- UNION-SET" s1 s2))))
  (reverse (union-iter s1 s2 empty-set)))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))
