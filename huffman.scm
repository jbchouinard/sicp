; Huffman Encoding Package
; From SICP s2.3

(load "~/.schemerc.scm")


; Tree procedures
(define (make-leaf symbol weight)
    (list 'leaf symbol weight))

(define (leaf? object)
    (eq? 'leaf (car object)))

(define symbol-leaf cadr)
(define weight-leaf caddr)

(define (make-code-tree left right)
    (list left
          right
          (append (symbols left) (symbols right))
          (+ (weight left) (weight right))))

(define left-branch car)
(define right-branch cadr)

(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf leaf))
        (caddr tree)))

(define (weight tree)
    (if (leaf? tree)
        (weight-leaf leaf)
        (cadddr tree)))

(define (choose-branch bit tree)
    (cond ((= bit 0) (left-branch tree))
          ((= bit 1) (right-branch tree)
          (else (error "bad bit -- CHOOSE-BRANCH" bit)))))

(define (decode bits tree)
    (define (decode-1 bits current-branch)
        (if (null? bits)
            '()
            (let ((next-branch (choose-branch (car bits) current-branch)))
                (if (leaf? next-branch)
                    (cons (symbol-leaf next-branch)
                          (decode-1 (cdr bits) tree))
                    (decode-1 (cdr-bits) next-branch)))))
    (decode-1 bits tree))
