;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; code to use in 3 player game
;;


(define (play-loop strat0 strat1 strat2)
  (define (play-loop-iter count history0 history1 history2 limit)
    (cond ((= count limit) (print-out-results history0 history1 history2 limit))
    (else (let ((result0 (strat0 history0 history1 history2))
          (result1 (strat1 history1 history0 history2))
          (result2 (strat2 history2 history0 history1)))
      (play-loop-iter (+ count 1)
          (extend-history result0 history0)
          (extend-history result1 history1)
          (extend-history result2 history2)
          limit)))))
  (play-loop-iter 0 the-empty-history the-empty-history the-empty-history
      (+ 90 (random 21))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  The following procedures are used to compute and print
;;  out the players' scores at the end of an iterated game
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (print-out-results history0 history1 history2 number-of-games)
  (let ((scores (get-scores history0 history1 history2)))
    (newline)
    (display "Player 1 Score:  ")
    (display (* 1.0 (/ (car scores) number-of-games)))
    (newline)
    (display "Player 2 Score:  ")
    (display (* 1.0 (/ (cadr scores) number-of-games)))
    (newline)
    (display "Player 3 Score:  ")
    (display (* 1.0 (/ (caddr scores) number-of-games)))
    (newline)))

(define (get-scores history0 history1 history2)
  (define (get-scores-helper history0 history1 history2 score0 score1 score2)
    (cond ((empty-history? history0)
     (list score0 score1 score2))
    (else (let ((game (make-play (most-recent-play history0)
                                 (most-recent-play history1)
                                 (most-recent-play history2))))
      (newline)
      (display game)
      (display "  ")
      (display (list score0 score1 score2))
      (get-scores-helper (rest-of-plays history0)
             (rest-of-plays history1)
             (rest-of-plays history2)
             (+ (get-player-points 0 game) score0)
             (+ (get-player-points 1 game) score1)
             (+ (get-player-points 2 game) score2))))))
  (get-scores-helper history0 history1 history2 0 0 0))

(define (get-player-points num game)
  (list-ref (get-point-list game) num))

(define (get-point-list game)
  (cadr (extract-entry game *game-association-list*)))

;; note that you will need to write extract-entry

(define (extract-entry game game-list)
  (define (extract-iter rest-of-list)
    (let ((next (car rest-of-list)))
      (if (and (string=? (car game) (caar next))
               (string=? (cadr game) (cadar next))
               (string=? (caddr game) (caddar next)))
          next
          (extract-iter (cdr rest-of-list)))))
  (extract-iter game-list))

(define make-play list)

(define the-empty-history '())

(define extend-history cons)
(define empty-history? null?)

(define most-recent-play car)
(define rest-of-plays cdr)

(define *game-association-list*
  (list (list (list "c" "c" "c") (list 4 4 4))
        (list (list "c" "c" "d") (list 2 2 5))
        (list (list "c" "d" "c") (list 2 5 2))
        (list (list "d" "c" "c") (list 5 2 2))
        (list (list "c" "d" "d") (list 0 3 3))
        (list (list "d" "c" "d") (list 3 0 3))
        (list (list "d" "d" "c") (list 3 3 0))
        (list (list "d" "d" "d") (list 1 1 1))))


(define (NASTY my-history other-history other-history2)
  "d")

(define (PATSY my-history other-history other-history2)
  "c")

(define (SPASTIC my-history other-history other-history2)
  (if (= (random 2) 0)
      "c"
      "d"))

(define (tough-eye-for-eye))

; in expected-values: #f = don't care
;                      X = actual-value needs to be #f or X
(define (test-entry expected-values actual-values)
   (cond ((null? expected-values) (null? actual-values))
         ((null? actual-values) #f)
         ((or (not (car expected-values))
              (not (car actual-values))
              (= (car expected-values) (car actual-values)))
          (test-entry (cdr expected-values) (cdr actual-values)))
         (else #f)))

(define (is-he-a-fool? hist0 hist1 hist2)
   (test-entry (list 1 1 1)
               (get-probability-of-c
                (make-history-summary hist0 hist1 hist2))))

(define (could-he-be-a-fool? hist0 hist1 hist2)
  (test-entry (list 1 1 1)
              (map (lambda (elt)
                      (cond ((null? elt) 1)
                            ((= elt 1) 1)
                            (else 0)))
                   (get-probability-of-c (make-history-summary hist0
                                                               hist1
                                                               hist2)))))
