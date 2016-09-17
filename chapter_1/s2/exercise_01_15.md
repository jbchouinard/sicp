# SICP Exercise 1.15

a. The procedure will be applied 5 times:

	(sine 12.15)
	(p (sine 4.05))
	(p (p (sine 1.3499999999999998)))
	(p (p (p (sine 0.4499999999999998))))
	(p (p (p (p (sine 0.14999999999999992)))))
	(p (p (p (p (p (sine 0.04999999999999999))))))
	(p (p (p (p (p 0.04999999999999999)))))


b. The order of growth in both number of steps and space is \\(\Theta(log(n))\\). Or maybe growth in space is \\(\Theta(1)\\) thanks to tail call elimination.