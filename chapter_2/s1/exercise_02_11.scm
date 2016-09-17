; SICP Exercise 2.11

(load "~/.schemerc.scm")

(define (mul-interval x y)
  (cond ((> (lower-bound x) 0)
          (cond ((> (lower-bound y) 0)
                  (make-interval (* (lower-bound x) (lower-bound y))
                                 (* (upper-bound x) (upper-bound y))))
                ((< (upper-bound (y)) 0)
                  (make-interval (* (upper-bound x) (lower-bound y))
                                 (* (lower-bound x) (upper-bound y))))
                (else
                  (make-interval (* (upper-bound x) (lower-bound y))
                                 (* (upper-bound x) (upper-bound y))))))
        ((< (upper-bound x) 0)
          (cond ((> (lower-bound y) 0)
                  (make-interval (* (upper-bound x) (lower-bound y))
                                 (* (lower-bound x) (upper-bound y))))
                ((< (upper-bound (y)) 0)
                  (make-interval (* (upper-bound x) (upper-bound y))
                                 (* (lower-bound x) (lower-bound y))))
                (else
                  (make-interval (* (lower-bound x) (upper-bound y))
                                 (* (lower-bound x) (lower-bound y))))))
        (else
         (cond ((> (lower-bound y) 0)
                  (make-interval (* (lower-bound x) (upper-bound y))
                                 (* (upper-bound x) (upper-bound y))))
                ((< (upper-bound (y)) 0)
                  (make-interval (* (upper-bound x) (lower-bound y))
                                 (* (lower-bound x) (lower-bound y))))
                (else
                  (let ((p1 (* (lower-bound x) (lower-bound y)))
                        (p2 (* (lower-bound x) (upper-bound y)))
                        (p3 (* (upper-bound x) (lower-bound y)))
                        (p4 (* (upper-bound x) (upper-bound y))))
                    (make-interval (min p2 p3)
                                   (max p1 p4))))))))
