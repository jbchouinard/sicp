import sys

BASE_PATH = "/home/jbchouinard/projets/sicp/jbwiki/contents/SICP"
LIB_PATH = "/home/jbchouinard/.local/lib/scheme/sicp"


def exercise_gen(chapter, section, from_, to):
    path = "%s/chapter_%i/s%i/exercise_%02i_%02i.scm"

    for i in range(from_, to + 1):
        fpath = path % (BASE_PATH, chapter, section, chapter, i)
        fn = fpath.split('/')[-1]
        fpath_next = path % (BASE_PATH, chapter, section, chapter, i+1)
        fn_next = fpath_next.split('/')[-1]

        with open(fpath, 'w') as f:
            f.write('; SICP Exercise %i.%i\n\n' % (chapter, i))
            f.write('(load "~/.schemerc.scm\n")')
            f.write('(define (reload) (load "%s"))\n' % fn)
            if i < to:
                f.write('(define (load-next) (load "%s"))\n\n' % fn_next)


if __name__ == '__main__':
    assert len(sys.argv) == 5
    args = (int(arg) for arg in sys.argv[1:])
    exercise_gen(*args)
