#!/usr/bin/env python3
import sys

txt = """; SICP Exercise {c}.{i}

"""

if __name__ == '__main__':
    c = int(sys.argv[1])
    m = int(sys.argv[2])
    n = int(sys.argv[3])

    for i in range(m, n, 1):
        with open('{}.scm'.format(i), 'w') as f:
            f.write(txt.format(i=i, c=c))
