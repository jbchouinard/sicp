; SICP Exercise 2.49



; Use segments->painter to define the following primitive painters:

; a. The painter that draws the outline of the designated frame.
(define painter-outline (segments->painter
  (points->segments (list (make-vect 0 0)
                          (make-vect 0 1)
                          (make-vect 1 1)
                          (make-vect 1 0)
                          (make-vect 0 0)))))

; b. The painter that draws an ‘‘X’’ by connecting opposite corners of the frame.

(define painter-x (segments->painter
  (list (make-segment (make-vect 0 0) (make-vect 1 1))
        (make-segment (make-vect 0 1) (make-vect 1 0)))))

; c. The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.

(define painter-diamond (segments->painter
  (points->segments (list (make-vect 0.5 0)
                          (make-vect 1 0.5)
                          (make-vect 0.5 1)
                          (make-vect 0 0.5)
                          (make-vect 0.5 0)))))

; d. The wave painter.
; Whatever
