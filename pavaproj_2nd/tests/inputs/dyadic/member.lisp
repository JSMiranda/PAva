(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(member? (v 1 2 3 4 5 6) (v 1 3 4 6))
(member? (v 1 2 3 4 5 6) (v 1 -2 -3 4))
(member? (v 1 2 3 4 5 6) (reshape (v 2 2) (v 1 3 4 6)))
(member? (reshape (v 3 2) (v 1 2 3 4 5 6)) (v 1 3 4 6))
(member? (reshape (v 3 2) (v 1 2 3 4 5 6)) (reshape (v 2 2) (v 1 3 4 6)))

