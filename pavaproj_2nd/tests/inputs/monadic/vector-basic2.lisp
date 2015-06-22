(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(.! (v 1 2 3 4 5))
(.sin (v 1 2 -3 -4 5))
(.cos (v 1 2 -3 -4 5))

