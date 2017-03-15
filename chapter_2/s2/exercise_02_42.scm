; SICP Exercise 2.42



(define enumerate-interval range-1)

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board nil)

(define (adjoin-position new-row rest-of-queens)
  (cons new-row rest-of-queens))

(define (safe? positions)
  (if (null? positions)
    true
    (let ((k (car positions)))
      (define (safe-iter m rest-of-positions)
        (cond ((null? rest-of-positions) true)
              ((= k (car rest-of-positions)) false)
              ((= (+ k m) (car rest-of-positions)) false)
              ((= (- k m) (car rest-of-positions)) false)
              (else (safe-iter (+ m 1) (cdr rest-of-positions)))))
      (safe-iter 1 (cdr positions)))))
