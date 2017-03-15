; SICP Exercise 2.39



(define (reverse-right sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(define (reverse-left seq)
  (fold-left (lambda (x y) (cons y x)) nil seq))
