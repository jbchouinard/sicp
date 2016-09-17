; SICP Exercise 2.52

(load "~/.schemerc.scm")

(define (make-recursive-painter painter frame-trans n)
  (lambda (frame-outer)
    (define (paint-iter k painter-mod)
      (painter-mod frame-outer)
      (if (> k 0)
        (paint-iter (- k 1) (transform-painter painter-mod frame-trans))))
    (paint-iter n painter)))

define painter-outline (segments->painter (points->segments
    (list (make-vect 0 0)
          (make-vect 0 1)
          (make-vect 1 1)
          (make-vect 1 0)
          (make-vect 0 0)))))

(define painter-x (segments->painter
  (list (make-segment (make-vect 0 0) (make-vect 1 1))
        (make-segment (make-vect 0 1) (make-vect 1 0)))))

(define painter-diamond (transform-painter painter-outline diamond-frame))

(define painter-cross (transform-painter painter-x diamond-frame))

(define painter-shapes
  (lambda (frame)
    ((below (beside painter-cross (compose painter-diamond painter-x))
            (beside painter-outline painter-cross)) frame)))

(define painter-shapes-rec (make-recursive-painter painter-shapes tl-frame 7))
