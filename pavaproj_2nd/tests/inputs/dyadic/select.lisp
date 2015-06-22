(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(select (v 1 0 1 1 0 1 0 0) (v 1 2 3 4 5 6 7 8))
(select (v 1 0 1 1 0 0) (reshape (v 2 6) (v 1 2 3 4 5 6 7 8 9 10 11 12)))
(select (v 1 0 1 1) (v 1 2 3 4 5 6 7 8))

