#!/usr/bin/env python3
import sys

txt = """; SICP Exercise 2.{i}

(load "~/.schemerc.scm")

(define (reload) (load "{i}.scm"))
"""

if __name__ == '__main__':
    m = int(sys.argv[1])
    n = int(sys.argv[2])

    for i in range(m, n, 1):
        with open('{}.scm'.format(i), 'w') as f:
            f.write(txt.format(i=i))
