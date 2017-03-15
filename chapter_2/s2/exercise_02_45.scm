; SICP Exercise 2.45



; Right-split and up-split can be expressed as instances of a general splitting operation. Define a procedure split with the property that evaluating
;
; (define right-split (split beside below))
; (define up-split (split below beside))

(define (split proc1 proc2)
  (define (split-rec painter n)
   (if (= n 0)
      painter
      (let ((smaller (split-rec painter (- n 1))))
           (proc1 painter (proc2 smaller smaller)))))
  (lambda (painter n) (split-rec painter n)))
