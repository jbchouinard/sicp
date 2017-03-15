; SICP Exercise 2.25



;Give combinations of cars and cdrs that will pick 7 from each of the following lists:

;(1 3 (5 7) 9)
(cdr (cdr (car (cdr lst))))

;((7))
(car (car lst))

;(1 (2 (3 (4 (5 (6 7))))))

(cdr (cdr (cdr (cdr (cdr (cdr lst))))))
