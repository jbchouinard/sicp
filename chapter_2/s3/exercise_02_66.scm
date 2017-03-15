; SICP Exercise 2.66



(define (reload) (load "exercise_02_66.scm"))
(define (load-next) (load "exercise_02_67.scm"))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))

; For testing purposes, we'll have a 'record' be a single number
(define (key record) record)

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      false
      (let ((this-key (key (entry set-of-records))))
        (cond ((equal? given-key this-key) (entry set-of-records))
              ((< given-key this-key) (lookup given-key (left-branch set-of-records)))
              (else (lookup given-key (right-branch set-of-records)))))))

(define test-records (list->tree '(1 3 5 7 9 11 13 15 17 19 21)))
(define test-result-13 (lookup 13 test-records))
(define test-result-false (lookup 14 test-records))
