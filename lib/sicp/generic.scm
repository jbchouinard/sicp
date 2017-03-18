; Data-directed Generic Programming Package

(require "schemerc")
(require "sicp.structure.table")

(define generic-ops-table (make-table))
(define put (table-make-put generic-ops-table))
(define get (table-make-get generic-ops-table))

(define generic-coercion-table (make-table))
(define put-coercion (table-make-put generic-coercion-table))
(define get-coercion (table-make-get generic-coercion-table))

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
  (if debug
    (begin
      (display (list 'apply-generic op args))
      (display "\n"))
    nil)
  (let ((types (map get-tag args))
        (vals (map get-content args)))
    (let ((func (get op types)))
      (cond
        (func
          (apply func vals))
        ((and (= (length args) 2) (not (eq? (car types) (cadr types))))
          (let ((t1 (car types))
                (t2 (cadr types))
                (a1 (car args))
                (a2 (cadr args))
                (v1 (car vals))
                (v2 (cadr vals)))
            (let ((t1->t2 (get-coercion t1 t2))
                  (t2->t1 (get-coercion t2 t1)))
              (cond (t1->t2 (apply-generic op (list (t1->t2 v1) a2)))
                    (t2->t1 (apply-generic op (list a1 (t2->t1 v2))))
                    (else (error "not implemented -- APPLY-GENERIC" op types))))))
        (else
          (error "not implemented -- APPLY-GENERIC" op types))))))

(define (make-generic op type args)
  (let ((func (get op type)))
    (if (eq? false func)
      (error "not implemented -- MAKE-GENERIC" type)
      (apply func args))))
