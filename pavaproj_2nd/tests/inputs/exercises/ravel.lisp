(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(ravel (v 1 2 3 4 5))
(ravel (v 1 2 3 4 5 6 7))
(ravel (reshape (v 2 2) (v 1 2 3)))
(ravel (reshape (v 2 3 4) (v 1 2 3 4 5 6)))
(ravel (reshape (v 2 2 2 2 2) (v 1 2 3 4 5 6)))
(ravel (reshape (v 2 3 4 5 6) (v 1 2 3 4 5)))

