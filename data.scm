; SICP Data Manipulation Package



; ------------------------- List Operations -------------------------
(define (for-earch f lst)
  (cond ((null? lst) #t)
        (else (f (car lst))
              (for-each f (cdr lst)))))

(define (last-pair lst)
  (if (null? (cdr lst))
    lst
    (last-pair (cdr lst))))

(define (reverse seq)
  (fold-left (lambda (x y) (cons y x)) nil seq))

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
      (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (fold-right op init (map car seqs))
          (fold-right-n op init (map cdr seqs)))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
          (cons (car sequence)
                (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s)))
          (first (car s)))
      (append rest (map (lambda (lst) (cons first lst)) rest)))))

(define (range low high step)
  (define (iter n lst)
    (if (> n high)
      lst
      (iter (+ n step) (cons n lst))))
  (reverse (iter low nil)))

(define (range-1 low high)
  (range low high 1))

; Map procedure and flattens a list of list to a list
(define (flatmap proc seq)
  (fold-right append nil (map proc seq)))


; ------------------------- Tree Operations -------------------------
(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (fold-right + 0 (map (lambda (x) 1) (enumerate-tree t))))

(define (tree-map f tree)
 (define (tree-map-inner tr)
  (cond ((null? tr) nil)
        ((not (pair? tr)) (f tr))
        (else (map tree-map-inner tr))))
  (tree-map-inner tree))


; ------------------------- Matrix Operations -------------------------
(define (dot-product v w)
  (fold-right + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product v x)) m))

(define (transpose mat)
  (fold-right-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v) (matrix-*-vector cols v)) m)))

