; Scheme Initialization

; ------------------------- Settings -------------------------
(define libpath "~/.local/lib/scheme/")
(define debug false)

; ------------------------- Names -------------------------
(define true #t)
(define false #f)
(define nil '())

; ------------------------- Utility Procedures -------------------------
(define (assert val symbol)
  (if (not val)
      (error "assertion error --" symbol val)))

(define (load-module module)
  (load (string-append libpath (string-replace module #\. #\/) ".scm")))

; ------------------------- List Procedures -------------------------
(define (insert! lst el)
  (let ((head (car lst))
        (rest (cdr lst)))
    (set-car! lst el)
    (set-cdr! lst (cons head rest))))

(define (nth n lst)
  (cond
    ((null? lst) (error "NTH -- index too large"))
    ((= n 0) (car lst))
    (else (nth (- n 1) (cdr lst)))))
