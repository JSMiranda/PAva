(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(shape (v 1 2 3))
(shape (reshape (v 2 3) (v 1 2 3)))
(shape (reshape (v 2 3 4) (v 1 2 3)))
(shape (reshape (v 2 3 4 5 6 7 8) (v 1 2 3)))

