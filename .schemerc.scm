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
