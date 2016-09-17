# SICP Exercise 2.22

   Louis Reasoner tries to rewrite the first square-list procedure of exercise 2.21 so that it evolves an iterative process:

  (define (square-list items)
    (define (iter things answer)
      (if (null? things)
          answer
          (iter (cdr things)
                (cons (square (car things))
                      answer))))
    (iter items nil))

  Unfortunately, defining square-list this way produces the answer list in the reverse order of the one desired. Why?

The first element of items is 'consed' to nil first, so it becomes the 'rightmost' (last) item of the new list. Imagine if you had a stack of coins, and created a new stack by taking the first coin on top, writing a number on it, and putting it on the new stack. The new stack would be in the reverse order. This is what's happening.

  Louis then tries to fix his bug by interchanging the arguments to cons:

  (define (square-list items)
    (define (iter things answer)
      (if (null? things)
          answer
          (iter (cdr things)
                (cons answer
                      (square (car things))))))
    (iter items nil))

  This doesn't work either. Explain.

nil will be at the top of the coin stack instead of being at the bottom, so to speak.
