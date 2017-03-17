; SICP Exercise 2.74

(require "sicp.structure.table")

(define opstable (make-table))
(define get (table-make-get opstable))
(define put (table-make-put opstable))

; Each division gets a unique type tag, and are responsible for implementing
; file and record access methods and registering them using put.
(define (attach-tag tag content)
  (cons tag content))

(define (get-tag item)
  (car item))

(define (get-content item)
  (cdr item))

; a. implement get-record
(define (get-record employee-name file)
  (let ((tag (get-tag file)))
    (attach-tag tag
      ((get 'get-record tag) employee-name (get-content file)))))

; b. implement get-salary
(define (get-information key record)
  ((get 'get-information (get-tag record)) key (get-content record)))

(define (get-salary employee-name file)
  (get-information 'salary
                   (get-record employee-name
                               file)))

; c. implement find-employee-record
(define (find-employee-record employee-name files)
  (define (find-iter remaining)
    (if (null? remaining)
      false
      (let ((record (get-record employee-name (car files))))
        (if (equal? false record)
          (find-iter (cdr files))
          record))))
  (find-iter files))

; d. Assuming the records at the company have the same general structure
; (file containing a set of records, record containing a set of attribute),
; a tag must be assigned for each file type at the new company, and accessor
; methods must be implemented and added to the central system for each file
; type.

; Example implementation of a divsion file package
(define (install-example-division-package)
  ; Implementation
  (define (get-record employee-name file)
    (table-get file employee-name false))
  (define (get-information key record)
    (table-get record key false))
  ; Interface
  (put 'get-record 'example get-record)
  (put 'get-information 'example get-information)
  'done)

; Example division file
(define (make-file-example)
  (attach-tag 'example (make-table)))
(define file-example (make-file-example))
(table-rec-set! (get-content file-example)
                (list "Patrick Bateman" 'salary)
                150000)
(table-rec-set! (get-content file-example)
                (list "Patrick Bateman" 'address)
                "55 Wall St., New York, NY, US")
(table-rec-set! (get-content file-example)
                (list "Patrick Bateman" 'position)
                "Vice-president")
