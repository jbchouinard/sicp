; SICP Exercise 2.10



(define (div x y)
  (if (= 0 (width y))
    (error "division by zero"))
    (mul x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))
