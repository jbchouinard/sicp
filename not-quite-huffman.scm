; This package almost but not quite implements Huffman encoding.
; This uses a different algorithm that I came up with when looking
; at Huffman trees before I actually looked up the Huffman algorithm.




; ------------------------- Symbol Table Procedures -------------------------

(define (make-symbol-table symbols relfreqs)
  (define (make-st-iter syms rfs)
    (if (null? syms)
        '()
         (cons (cons (car syms) (car rfs))
               (make-st-iter (cdr syms) (cdr rfs)))))
  (sort-symbol-table (make-st-iter symbols relfreqs)))

(define (sort-symbol-table st)
  (define (insert elt sorted)
    (cond ((null? sorted) (list elt))
          ((>= (cdr elt) (cdar sorted)) (cons elt sorted))
          (else (cons (car sorted) (insert elt (cdr sorted))))))
  (define (sort-iter lst sorted)
    (if (null? lst)
        sorted
        (sort-iter (cdr lst) (insert (car lst) sorted))))
  (sort-iter st '()))

(define (get-weight symbol symbol-table)
  (if (equal? symbol (caar symbol-table))
      (cdar symbol-table)
      (get-weight symbol (cdr symbol-table))))

(define (get-weight-sum symlist symbol-table)
  (define (wt-iter wt syms)
    (if (null? syms)
        wt
        (wt-iter (+ wt (get-weight (car syms) symbol-table))
                 (cdr syms))))
  (wt-iter 0 symlist))

; Returns: (left-symbols right-symbols) such that
; the weights of the left and right symbol sets is split roughly evenly
(define (split-by-weight symbols symbol-table)
  (define (split-iter left right lwt rwt)
    (if (>= lwt rwt)
        (cons (reverse left) right)
        (let ((next-right (car right))
              (rest-right (cdr right))
              (next-wt (get-weight (car right) symbol-table)))
          (split-iter (cons next-right left) rest-right (+ lwt next-wt) (- rwt next-wt)))))
  (split-iter '() symbols 0 (get-weight-sum symbols symbol-table)))

(define (list-symbols st)
  (define (ls-iter table syms)
    (if (null? table)
        syms
        (ls-iter (cdr table) (cons (caar table) syms))))
  (reverse (ls-iter st '())))

; Tests
(define test-st (make-symbol-table '(a b c d e f) '(5 2 3 4 6 1)))
(define test-st-sort (caar test-st))
(assert (equal? test-st-sort 'e) 'test-st-sort)
(define test-st-weight (get-weight 'e test-st))
(assert (= test-st-weight 6) 'test-st-weight)
(define test-st-weight-sum (get-weight-sum '(a b c d e f) test-st))
(assert (= test-st-weight-sum 21) 'test-st-weight-sum)
(define test-st-list (list-symbols test-st))
(assert (equal? test-st-list '(e a d c b f)) 'test-st-list)
(define test-st-split (split-by-weight test-st-list test-st))
(assert (equal? test-st-split '((e a) d c b f)) 'test-st-split)


; ------------------------- Encoding Tree Helper Procedures -------------------------

(define (symbols encoding)
  (car encoding))

(define (left-branch encoding)
  (cadr encoding))

(define (right-branch encoding)
  (caddr encoding))

(define (element? symbol symlist-or-symbol)
  (define (lst-elt? symbol symlist)
     (cond ((null? symlist) false)
           ((equal? symbol (car symlist)) true)
           (else (lst-elt? symbol (cdr symlist)))))
  (if (pair? symlist-or-symbol)
      (lst-elt? symbol symlist-or-symbol)
      (equal? symbol symlist-or-symbol)))

(define (encode-sym symbol encoding)
  (cond ((eq? symbol (symbols encoding)) '())
        ((element? symbol (symbols (left-branch encoding)))
            (cons 0 (encode-sym symbol (left-branch encoding))))
        ((element? symbol (symbols (right-branch encoding)))
            (cons 1 (encode-sym symbol (right-branch encoding))))
        (else (error "what is this? -- ENCODE-SYM" symbol))))

; Returns: (symbol rest-of-message)
(define (decode-next-sym code encoding)
  (cond ((not (pair? (symbols encoding))) (cons (symbols encoding) code))
        ((= 0 (car code)) (decode-next-sym (cdr code) (left-branch encoding)))
        ((= 1 (car code)) (decode-next-sym (cdr code) (right-branch encoding)))
        (else (error "what is this? -- DECODE-NEXT-SYM" code))))


; ------------------------- Encode/Decode Procedures -------------------------

(define (encode message encoding)
  stuff)

(define (decode message encoding)
  stuff)

(define (make-encoding symbol-table)
  stuff)

(define (print-encoding encoding)
  (define (tree-iter enc code)
  stuff))


