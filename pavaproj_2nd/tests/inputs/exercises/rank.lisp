(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(rank (v 1 2 3))
(rank (v 1 2 3 4 5 6))
(rank (reshape (v 2 2) (v 1 2 3)))
(rank (reshape (v 2 6) (v 1 2 3)))
(rank (reshape (v 6 2) (v 1 2 3 4 5)))
(rank (reshape (v 2 4 5 2) (v 1 2 3 4 5)))
(rank (reshape (v 2 2 2 2 2 2 2) (v 1 2 3 4)))

