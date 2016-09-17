# SICP Exercise 1.19

Let

1. \\(a_{n+1} = b_{n}q + a_{n}q + a_{n}p \\)

2. \\(b_{n+1} = b_{n}p + a_{n}q\\)

for \\(n >= 0\\). That is, \\(a_n\\) is the result of applying the \\(T_{pq}\\) transformation \\(n\\) times to (\\(a_{0}, b_{0}\\)).

Then:

3. \\(a_{n+2} = b_{n+1}q + a_{n+1}q + a_{n+1}p \\)

4. \\(b_{n+2} = b_{n+1}p + a_{n+1}q\\)

Substituting 1 and 2 into 3 and 4:

5. \\(a_{n+2} = (b_{n}p + a_{n}q)q + (b_{n}q + a_{n}q + a_{n}p)q + (b_{n}q + a_{n}q + a_{n}p)p \\)

6. \\(b_{n+2} = (b_{n}p + a_{n}q)p + (b_{n}q + a_{n}q + a_{n}p)q\\)

Let

7. \\(a_{n+2} = b_{n}q' + a_{n}q' + a_{n}p'\\)

8. \\(b_{n+2} = b_{n}p' + a_{n}q'\\)

Substituting 8 into 6, and simplifying:

9. \\(b_{n}p' + a_{n}q' = b_{n}(p^2 + q^2) + a_{n}(q^2 + 2pq)\\)

We can thus define a transformation \\(T_{p'q'}\\) that is the equivalent of applying \\(T_{pq}\\) twice, where

\\(p' = p^2 + q^2\\)

\\(q' = q^2 + 2pq\\)