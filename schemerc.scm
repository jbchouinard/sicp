; Scheme Customizations

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
      (error "assertion error -- ASSERT" val symbol)))

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
    ((null? lst) (error "index too large -- NTH" n lst))
    ((= n 0) (car lst))
    (else (nth (- n 1) (cdr lst)))))
