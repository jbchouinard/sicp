; SICP Exercise 2.32



; We can represent a set as a list of distinct elements, and we can represent the set of all
; subsets of the set as a list of lists. For example, if the set is (1 2 3), then the set of
; all subsets is

; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)).
;
; Complete the following definition of a
; procedure that generates the set of subsets of a set and give a
; clear explanation of why it works:

(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s)))
          (first (car s)))
      (append rest (map (lambda (lst) (cons first lst)) rest)))))

; It works because the subsets of the set s = (s1 s2 s3 ... sn) is made up of
; all the subsets of the set (s2 s3 ... sn), plus all those same subsets, with
; the addition of s1.

; All subsets either include s1, or don't. The subsets that don't include s1
; are the same as all subsets of the set that includes all the elements of our set except
; s1 (that is, cdr s). The subsets that include s1 can be obtained by adding s1 to each subset
; that doesn't contain s1.
