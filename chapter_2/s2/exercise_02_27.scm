; SICP Exercise 2.27

(load "~/.schemerc.scm")

(define nil (list))

(define (reverse lst)
  (define (reverse-iter llst rlst)
    (if (null? llst)
      rlst
      (reverse-iter (cdr llst) (cons (car llst) rlst))))
  (reverse-iter lst nil))

(define (deep-reverse lst)
  (define (rev-iter llst rlst)
    (if (null? llst)
      rlst
      (let ((next (car llst)))
        (if (pair? next)
          (rev-iter (cdr llst) (cons (rev-iter (car llst) nil) rlst))
          (rev-iter (cdr llst) (cons (car llst) rlst))))))
  (rev-iter lst nil))
