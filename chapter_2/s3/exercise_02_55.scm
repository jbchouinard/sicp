; SICP Exercise 2.55

(load "~/.schemerc.scm")

; The expression:
; (car ''abracadabra)
; is equivalent to:
; (car (quote (quote abracadabra)))
; (quote (quote abracadabra))
; is interpreted as the list of symbols '(quote abracadabra)
; the first element of which, retrieved by car, is
; the symbol quote (*not* the procedure that the
; variable quote evaluates to)
