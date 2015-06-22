(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(tally (v 1 2 3 4))
(tally (v 1 2 3 4 5 -1 -2 -3 -4 -5))
(tally (reshape (v 2 2) (v 1 2 3 4)))
(tally (reshape (v 6 2) (v 1 2 3 4 5)))
(tally (reshape (v 2 6) (v 1 2 3 4 5)))
(tally (reshape (v 2 3 4) (v 1 2 3 4 5)))
(tally (reshape (v 4 3 2 5 6 4) (v 1 2 3 4 5)))

