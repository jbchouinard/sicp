; SICP Set Package - Binary Tree Representation

(require "sicp.structure.binary-tree")

; ------------------------- Tree Set Procedures -------------------------

(define (list->tree-set elements)
  (car (partial-tree-set elements (length elements))))

(define (partial-tree-set elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree-set elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree-set (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))


; ------------------------- Set Procedures -------------------------

(define empty-set '())

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

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
  (list->tree (reverse (union-iter (tree->list s1) (tree->list s2) empty-set))))
