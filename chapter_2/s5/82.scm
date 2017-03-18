; SICP Exercise 2.82

(require "sicp.structure.list")
(require "sicp.generic")


; Try to find a coercion for provided operation and argument types
; Returns: a list of coercion procedures
(define (find-coercion op argtypes)
  (define (has-op? type)
    (let ((types (make-list (length argtypes) type)))
      (not (eq? false (get op types)))))
  (define (get-coercion-or-id type-from type-to)
    (if (eq? type-from type-to)
      (lambda (x) (attach-tag type-to x)) ; identity
      (get-coercion type-from type-to)))
  (define (coerce-to type)
    (map (lambda (t) (get-coercion-or-id t type)) argtypes))
  (define (find-iter types-to-try)
    (if (null? types-to-try)
      false
      (let ((coercions (coerce-to (car types-to-try))))
        (if (every (lambda (f) f) coercions)
          coercions
          (find-iter (cdr types-to-try))))))
  (find-iter (filter has-op? (delete-duplicates argtypes))))

(define (apply-generic op args)
  (let ((types (map get-tag args))
        (vals (map get-content args)))
    (let ((func (get op types)))
      (cond
        (func
          (apply func vals))
        ((not (all-equal? types))
          (let ((coercions (find-coercion op types)))
            (if (eq? false coercions)
              (error "not implemented -- APPLY-GENERIC" op types)
              (apply-generic op (map-apply coercions (map list vals))))))
        (else
          (error "not implemented -- APPLY-GENERIC" op types))))))
