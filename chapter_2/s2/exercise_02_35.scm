; SICP Exercise 2.35

(load "~/.schemerc.scm")

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree t))))
