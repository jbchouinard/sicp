; SICP Picture Language Package


; ------------------------- Vectors and Segments -------------------------
; In the context of this package, a vector (or point) is a pair of x, y coordinates.
; A segment is a line defined by a pair of vectors.

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

(define (make-segment start-vec end-vec)
  (cons start-vec end-vec))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))


; ------------------------- Frames Procedures -------------------------
; A frame is made up of three vectors:
;  - the origin, and two edges
; The corners of the frame are made up of the sum of the origin
; with each of the edges.

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (car (cdr (cdr frame))))

(define (corner1-frame frame)
  (add-vect (origin-frame frame) (edge1-frame frame)))

(define (corner2-frame frame)
  (add-vect (origin-frame frame) (edge2-frame frame)))

; Make a procedure that maps coordinates in (0, 0) to (1, 1) onto the frame
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

; Return a frame that is equivalent of nesting frame-in into frame-out
(define (nest-frame frame-in frame-out)
  (let ((m (frame-coord-map frame-out)))
    (let ((new-origin (m (origin-frame frame-in))))
      (let ((new-edge1 (sub-vect (m (corner1-frame frame-in)) new-origin))
            (new-edge2 (sub-vect (m (corner2-frame frame-in)) new-origin)))
        (make-frame new-origin new-edge1 new-edge2)))))


; ------------------------- Some Useful Frames -------------------------
(define full-frame (make-frame (make-vect 0 0)
                               (make-vect 1 0)
                               (make-vect 0 1)))

(define top-frame (make-frame (make-vect 0 0.5)
                                   (make-vect 1 0)
                                   (make-vect 0 0.5)))

(define bottom-frame (make-frame (make-vect 0 0)
                                      (make-vect 1 0)
                                      (make-vect 0 0.5)))

(define left-frame (make-frame (make-vect 0 0)
                                    (make-vect 0.5 0)
                                    (make-vect 0 1)))

(define right-frame (make-frame (make-vect 0.5 0)
                                     (make-vect 0.5 0)
                                     (make-vect 0 1)))

(define flip-vert-frame (make-frame (make-vect 0 1)
                                    (make-vect 1 0)
                                    (make-vect 0 (- 1))))

(define flip-hor-frame (make-frame (make-vect 1 0)
                                   (make-vect (- 1) 0)
                                   (make-vect 0 1)))

(define tr-frame (nest-frame top-frame right-frame))

(define tl-frame (nest-frame top-frame left-frame))

(define br-frame (nest-frame bottom-frame right-frame))

(define bl-frame (nest-frame bottom-frame left-frame))

; Rotated 90 degrees CCW
(define rotate90-frame (make-frame (make-vect 1 0)
                                   (make-vect 0 1)
                                   (make-vect (- 1) 0)))

(define rotate180-frame (nest-frame rotate90-frame rotate90-frame))

(define rotate270-frame (nest-frame rotate180-frame rotate90-frame))

(define diamond-frame (make-frame (make-vect 0 0.5)
                                  (make-vect 0.5 (- 0.5))
                                  (make-vect 0.5 0.5)))


; ------------------------- Graphics -------------------------
; For setting up the graphics environment

(define (graphics-get-dev)
  (make-graphics-device (car (enumerate-graphics-types))))

(define graphics-dev (graphics-get-dev))

(define (graphics-setup-dev dev)
 (graphics-set-coordinate-limits dev 0 0 1 1))

(define (graphics-make-draw-line dev)
    (graphics-setup-dev dev)
    (lambda (start-vec end-vec)
        (graphics-draw-line dev
        (xcor-vect start-vec) (ycor-vect start-vec)
        (xcor-vect end-vec) (ycor-vect end-vec))))

(define draw-line (graphics-make-draw-line graphics-dev))


; ------------------------- Painter Helpers -------------------------
; Procedures for the creation of painters
;
; A painter is a function that takes a frame as input, then draws
; a shape inside that frame.

; Turn a list of points (represented by vectors) into a list of segments
; that connects the points.
; For example, the points ((0 0) (0 1) (1 trac1)) are connected by the segments
; (((0 0) (0 1)) ((0 1) (1 1)))
; 'Shapes' are not closed by default; to close the shape formed by the list of
; points, the last and first points in the list should be the same.
(define (points->segments pts)
  (define (points-iter rest lst)
    (let ((head (car rest))
          (tail (cdr rest)))
      (if (null? tail)
          lst
          (points-iter tail (cons (make-segment head (car tail)) lst)))))
  (reverse (points-iter pts (list))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))


; ------------------------- Painter Procedures -------------------------
; Procedures that modify painters.

; I found it cleaner to make a transform-painter procedure
; that uses frames, and to move the business of
; projecting frames into each other at the abstraction
; layer of frames. That way the painter layer is completely
; agnostic to frame details.
(define (transform-painter painter frame-trans)
 (lambda (frame)
   (painter (nest-frame frame-trans frame))))

(define (flip-vert painter) (transform-painter painter flip-vert-frame))

(define (flip-horiz painter) (transform-painter painter flip-hor-frame))

(define (shrink-to-upper-right painter)
  (transform-painter painter top-right-frame))

(define (rotate90 painter)
  (transform-painter painter rotate90-frame))

(define (beside painter-left painter-right)
  (lambda (frame)
    ((transform-painter painter-left left-frame) frame)
    ((transform-painter painter-right right-frame) frame)))

(define (below painter-bottom painter-top)
  (lambda (frame)
   ((transform-painter painter-bottom bottom-frame) frame)
   ((transform-painter painter-top top-frame) frame)))

(define (compose painter1 painter2)
  (lambda (frame)
    (painter1 frame)
    (painter2 frame)))

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define (up-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (up-split painter (- n 1))))
         (below painter (beside smaller smaller)))))

(define (right-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (right-split painter (- n 1))))
         (beside painter (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
    painter
    (let ((up (up-split painter (- n 1)))
          (right (right-split painter (- n 1))))
      (let ((top-left (beside up up))
            (bottom-right (below right right))
            (corner (corner-split painter (- n 1))))
        (beside (below painter top-left)
        (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (make-recursive-painter painter frame-trans n)
  (lambda (frame-outer)
    (define (paint-iter k painter-mod)
      (painter-mod frame-outer)
      (if (> k 0)
        (paint-iter (- k 1) (transform-painter painter-mod frame-trans))))
    (paint-iter n painter)))


; ------------------------- A Few Simple Painters -------------------------

(define painter-outline (segments->painter (points->segments
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
