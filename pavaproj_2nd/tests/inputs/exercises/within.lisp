(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(within (v 1 2 3 4 5 6) (s 2) (s 4))
(within (v 1 2 3 4 5 6) (s 3) (s 8))
(within (v 6 5 4 3 2 1) (s 2) (s 4))
(within (v 1 -1 2 -2 3 -3 4 -4 5 -5 6 -6) (s -2) (s 2))

