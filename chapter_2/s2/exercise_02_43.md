# SICP Exercise 2.43

The problem with his version is that (queen-cols (- k 1)) is called k times when computing positions for k columns, compared to 1 time for the correct version.

Oversimplifying, we estimate that Louis's version will take ~8600T to complete for a board size of 8, if we assume that enumerating and checking new board positions for k columns once positions for k-1 columns is known is constant with k in time (which requires assuming that the number of board positions of (queen-cols (- k 1)) is constant with k, which is not quite correct).

We arrive at this number as follows. Assuming that enumerating and checking new rows for the known good board position takes time c, and that we have to check 8 new row positions for each k, the correct algorithm will take time 64c, since (queen-cols (- k 1)) is only computed once for each k. For Louis's version, (queen-cols 7) will be computed 8 times, and each of these will call (queen-cols 6) 7 times, and so on; there is exponential recursion. Thus, the time for Louis's version is:

\\[8c + 8 * (8c + 7 * (8c + 6 * ... + 2 * (8c))) = 554248c = 8660.125T \\]

But the assumption that there is a constant number of good board positions is constant with k is unrealistic. This number will grow with k. At most, the number of good positions, for a board size of 8, for k columns, k smaller than 8, is 8 raised to the kth power. (This is the total number of positions, of which a fraction are actually good/safe).

If we assume that all positions are good, instead of assuming a constant number of good board positions, the time taken by the faster algorithm is:

\\[8c * (8^7) + 8c * (8^6) + ... + 8c = 324518553658426726783156020576256c = 1T\\]

Louis's version, on the other hand, will take:

\\[8c * (8^7) + 7*(8c * (8^6) + 6*...(8c)) = 1635573510438470702987106343704330240c ~= 5040T\\]

The reality will be somewhere in between; that is, the correct number of good board position will grow, but not as fast as we have assumed in our second set of calculations.

Thus we can say that Louis's version will take somewhere between 5040 and 8660 times as long as the correct algorithm, for a board size of 8. (The bigger the board, the worse this will become).

