; SICP Exercise 2.77

; Trace trough a call to (magnitude z)
; Let's say z is a rect complex number, say (complex rectangle 1 . 1)
; (magnitude (complex rectangle 1 . 1))
; (apply-generic 'magnitude (complex rectangle 1 . 1))
; ((get 'magnitude '(complex)) (rectangle 1. 1))
; (apply-generic 'magnitude (rectangle 1 . 1))
; ((get 'magnitude '(rectangle) (1 . 1)))
; (magnitude (1 . 1))
