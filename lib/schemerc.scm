; Scheme Customizations


; ------------------------- Names -------------------------
(define true #t)
(define false #f)
(define nil '())

; ------------------------- Debug ------------------------
(define debug false)

(define (assert val symbol)
  (if (not val)
      (error "assertion error -- ASSERT" val symbol)))

; ------------------------- Module Mangement -------------------------
(define libpath "~/.local/lib/scheme/")

(define loaded-modules (list "schemerc"))

(define (loaded? module)
  (not (eq? false (find (lambda (x) (equal? x module)) loaded-modules))))

(define (load-module module)
  (let ((head (car loaded-modules))
        (rest (cdr loaded-modules)))
    (set-car! loaded-modules el)
    (set-cdr! loaded-modules (cons head rest)))
  (load (string-append libpath (string-replace module #\. #\/) ".scm")))

(define (require module)
  (if (loaded? module)
    nil
    (load-module module)))
