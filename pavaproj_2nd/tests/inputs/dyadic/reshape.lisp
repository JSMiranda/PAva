(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(reshape (v 3 2) (v 1 2 3 -1 -2))
(reshape (v 2 3) (v 1 2 3 -1 -2))
(reshape (v 3 3) (reshape (v 2 2) (v 1 2 3 4)))
(reshape (v 3 3 3 3) (reshape (v 4 4 4) (v 1 2 3 4 5 6 7 8 9 10 -1 -2 -3 -4 -5 -6 -7 -8 9 -10)))

