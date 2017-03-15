; SICP Exercise 2.60



(define (reload) (load "exercise_02_60.scm"))
(define (load-next) (load "exercise_02_61.scm"))

(define empty-set '())

(define (make-set . x)
  (define (make-set-iter set rest)
    (if (null? rest)
        set
        (make-set-iter (adjoin-set (car rest) set) (cdr rest))))
  (make-set-iter empty-set x))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define adjoin-set cons)

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define union-set append)

; Efficiency comparison

; Time
; element-of-set? is O(n) in each case. However n tends to be larger in this
; representation since there can be duplicates.

; adjoin-set is O(1) in this representation, compared to O(n) in the unique repr.

; intersection-set is O(n**2) in both cases (again, n is larger for this repr.)

; union-set is O(n) in this comparison, while it is O(n**2) in the other

; Space
; Obviously this representation takes more space. Exactly how much depends
; on how much overlap there is between sets that are unioned and adjoined.

; Applications
; This representation could make sense in the case where the program
; is working with sets that have a high degree of 'disjointness'.

; The problem is that the time gains are in the union and adjoin operations
; and those are precisely the operations that will make the sets explode in
; size in the duplicate representation.

; For example, repeatedly taking the union of a set with itself will make it
; double in size each time.

; It seems the only really useful application of this representation is when
; we are working with large, highly disjoint sets.

; For certain applications it would perhaps make sense to use a representation
; with duplicates, and occasionally dedupe the set (a O(n**2) operation)
; to make operations faster in most cases, but also also limit memory use.
; Exactly what 'occasionally' means here is a difficult question.

; Perhaps if we are working with large sets we could estimate the degree of
; duplication by occasionally calculating the duplication factor (the average
; number of times each element of the set appears, =1 in a set with no dupes),
; of a sample of the set, and if it is found to be high in the sample,
; dedupe the entire set. (It doesn't make sense to check the degree of duplication
; of the entire set, rather than a sample, because checking is O(n**2), just like
; deduping - if we were going to check the whole set, we might as well just dedupe it.)
