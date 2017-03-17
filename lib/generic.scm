; Data-directed Generic Programming Package

(define opstable (make-table))
(define put (table-make-put opstable))
(define get (table-make-get opstable))

(define (get-tag item)
  (if (number? item)
    'scheme-number
    (car item)))

(define (get-content item)
  (if (number? item)
    item
    (cdr item)))

(define (attach-tag tag content)
  (cons tag content))

(define (apply-generic op args)
  (let ((types (map get-tag args))
        (vals (map get-content args)))
    (let ((func (get op types)))
      (if (eq? false func)
        (error "not implemented -- APPLY-GENERIC" op types)
        (apply func vals)))))

(define (make-generic type args)
  (let ((func (get 'make type)))
    (if (eq? false func)
      (error "not implemented -- MAKE-GENERIC" type)
      (apply func args))))
