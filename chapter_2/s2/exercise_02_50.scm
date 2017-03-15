; SICP Exercise 2.50



; Return a frame that is equivalent of nesting frame-in into frame-out
(define (nest-frame frame-in frame-out)
  (let ((m (frame-coord-map frame-out)))
    (let ((new-origin (m (origin-frame frame-in))))
      (let ((new-edge1 (sub-vect (m (corner1-frame frame-in)) new-origin))
            (new-edge2 (sub-vect (m (corner2-frame frame-in)) new-origin)))
        (make-frame new-origin new-edge1 new-edge2)))))

(define flip-hor-frame (make-frame (make-vect 1 0)
                                   (make-vect (- 1) 0)
                                   (make-vect 0 1)))

(define (transform-painter painter frame-trans)
 (lambda (frame)
   (painter (nest-frame frame-trans frame))))

(define (flip-horiz painter) (transform painter flip-hor-frame))
