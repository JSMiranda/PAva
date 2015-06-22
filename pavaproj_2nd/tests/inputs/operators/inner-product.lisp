(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(funcall (inner-product #'.+ #'.*) (v 1 2 3 4) (v 10 20 30 40))
(funcall (inner-product #'.* #'.+) (v 1 2 3 4) (v 10 20 30 40))
(funcall (inner-product #'.- #'.*) (v 1 2 3 4) (v 10 20 30 40))
(funcall (inner-product #'.+ #'.*) (reshape (v 2 2) (v 1 2 3 4)) (reshape (v 2 2) (v 10 20 30 40)))
(funcall (inner-product #'.+ #'.*) (reshape (v 2 2) (v 1 2 3 4)) (reshape (v 2 3) (v 10 20 30 40 50 60)))
(funcall (inner-product #'.+ #'.*) (reshape (v 3 2) (v 1 2 3 4 5 6)) (reshape (v 2 3) (v 10 20 30 40 50 60)))
(funcall (inner-product #'.+ #'.*) (reshape (v 6 3) (v 1 2 3 4 5 6)) (reshape (v 3 6) (v 10 20 30 40 50 60)))

