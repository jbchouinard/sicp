; Table
; A simple lookup table

(define (make-table)
  (list 'table 'end))

(define (table? tbl)
  (eq? 'table (car tbl)))

(define (table-set! table key value)
  (assert (table? table) "not a table")
  (define (set-iter tbl)
    (cond ((eq? 'end (car tbl)) (insert! tbl (list key value)))
          ((equal? (caar tbl) key) (set-cdr! (car tbl) (list value)))
          (else (set-iter (cdr tbl)))))
  (set-iter (cdr table)))

(define (table-lookup table key)
  (assert (table? table) "not a table")
  (define (get-iter tbl)
    (cond ((eq? 'end (car tbl))
            (error "key not found -- TABLE-LOOKUP" key))
          ((equal? (caar tbl) key)
            (cadar tbl))
          (else
            (get-iter (cdr tbl)))))
  (get-iter (cdr table)))

(define (table-get table key default)
  (assert (table? table) "not a table")
  (define (get-iter tbl)
    (cond ((eq? 'end (car tbl)) default)
          ((equal? (caar tbl) key) (cadar tbl))
          (else (get-iter (cdr tbl)))))
  (get-iter (cdr table)))

(define (table-has-key table key)
  (assert (table? table) "not a table")
  (define (get-iter tbl)
    (cond ((eq? 'end (car tbl)) false)
          ((equal? (caar tbl) key) true)
          (else (get-iter (cdr tbl)))))
  (get-iter (cdr table)))

(define (table-getset! table key thunk)
  (if (table-has-key table key)
    (table-lookup table key)
    (let ((val (thunk)))
      (table-set! table key val)
      val)))

(define (table-rec-lookup table keys)
  (define (lookup-iter subtbl k ks)
    (if (null? ks)
      (table-lookup subtbl k)
      (lookup-iter (table-lookup subtbl k) (car ks) (cdr ks))))
  (lookup-iter table (car keys) (cdr keys)))

(define (table-rec-get table keys default)
  (define (lookup-iter subtbl k ks)
    (cond ((eq? default subtbl) default)
          ((null? ks) (table-get subtbl k default))
          (else (lookup-iter (table-get subtbl k default) (car ks) (cdr ks)))))
  (lookup-iter table (car keys) (cdr keys)))

(define (table-rec-set! table keys val)
  (define (set-iter subtbl k ks)
    (if (null? ks)
      (table-set! subtbl k val)
      (set-iter (table-getset! subtbl k make-table) (car ks) (cdr ks))))
  (set-iter table (car keys) (cdr keys)))

(define (table-make-put mytable)
  (lambda (key1 key2 val)
    (table-rec-set! mytable (list key1 key2) val)))

(define (table-make-get mytable)
  (lambda (key1 key2)
    (table-rec-get mytable (list key1 key2) false)))
