# SICP Exercise 2.13

In exercise 2.9, we have found that, for the interval Z, the product of intervals X and Y: \\(dz = xdy + ydx\\).

Where \\(x = center(X)\\) and \\(dx = width(X)\\).

Let \\(pct_x\\) be the percent tolerance of the interval X.

\\[pct_x = \frac{dx}{x}\\]

We can get \\(pct_z\\) by dividing dz by z = center(Z).

\\[z = \over{((xy + xdy + ydx + dxdy) + (xy - xdy - ydx + dydx))}{2}\\]

\\[z = xy + dydx\\]

If the tolerances on x and y are small percent values, \\(dydx\\) will be negligible compared to \\(xy\\), so we can approximate z by \\(z = xy\\), thus:

\\[pct_z = \frac{xdy + ydx}{xy} = \frac{dy}{y} + \frac{dx}{x} = pct_x + pct_y\\]
