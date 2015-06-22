(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(.! (reshape (v 3 2) (v 1 2 3 4 5 6)))
(.sin (reshape (v 3 2) (v 1 2 -3 -4 5 -6)))
(.cos (reshape (v 3 3) (v 1 2 -3 -4 5 -6)))

