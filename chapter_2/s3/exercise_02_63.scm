; SICP Exercise 2.63



(define (reload) (load "exercise_02_63.scm"))
(define (load-next) (load "exercise_02_64.scm"))

; Each of the following two procedures converts a binary tree to a list.

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

; a. Do the two procedures produce the same result for every tree?
; If not, how do the results differ? What lists do the two procedures produce
; for the trees in figure 2.16?

; The two procedures produce the same result for every tree

; tree->list1 would produce the lists:
; (1 3 5 7 9 11)
; (1 3 5 7 9 11)
; (1 3 5 7 9 11)

; tree->list2 would produce the lists:
; (1 3 5 7 9 11)
; (1 3 5 7 9 11)
; (1 3 5 7 9 11)

; b. Do the two procedures have the same order of growth in the number of steps
; required to convert a balanced tree with n elements to a list?
; If not, which one grows more slowly?

; tree->list-2 grows more slowly since appending is a more step-expensive operation
; than cons-ing.

; For a balanced tree of size n, the append operation at the root of the tree will
; take n/2 steps. Then at the level below, there will be 2 append operations, each taking
; n/4 steps, and so on; the tree has log n levels, so in total the append operations will
; take on the order of n log n steps. Meanwhile, tree->list-2 only performs a cons for each
; entry; cons is O(1), there are n entries, so the procedure grows as O(n).
