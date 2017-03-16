; SICP Exercise 2.74

(load-module "sicp.table")

(define opstable (make-table))
(define get (table-make-get opstable))
(define put (table-make-put opstable))

; a.
(define (get-record employee-name file)
  ((get 'get-record (list employee-name file))))
; The 
