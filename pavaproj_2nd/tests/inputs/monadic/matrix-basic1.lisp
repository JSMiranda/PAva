(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(.- (reshape (v 2 3) (v 1 2 -3 -4 5 -6)))
(./ (reshape (v 2 3) (v 1 2 -3 -4 5 -6)))
(.not (reshape (v 3 3) (v 1 2 -3 -4 5 -6)))

