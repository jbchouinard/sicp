(require "schemerc")

(define (nth n lst)
  (cond
    ((null? lst) (error "index too large -- NTH" n lst))
    ((= n 0) (car lst))
    (else (nth (- n 1) (cdr lst)))))

(define (insert! lst el)
  (let ((head (car lst))
        (rest (cdr lst)))
    (set-car! lst el)
    (set-cdr! lst (cons head rest))))

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

; Map procedure and flattens a list of list to a list
(define (flatmap proc seq)
  (fold-right append nil (map proc seq)))

(define (all-equal? lst)
  (let ((first (car lst))
        (rest (cdr lst)))
    (every (lambda (x) (equal? x first)) rest)))

; Apply a list of procedures to a list of arguments
(define (map-apply procs args)
  (map (lambda (p) (apply (car p) (cadr p))) (zip procs args)))
