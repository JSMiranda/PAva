(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(funcall (outer-product #'.+) (v 1 2 3 4) (v 1 -2 -3 4))
(funcall (outer-product #'.-) (v 1 2 3 4) (v 1 -2 -3 4))
(funcall (outer-product #'.*) (v 1 2 3 4) (v 1 -2 -3 4))
(funcall (outer-product #'.>) (v 1 2 3 4) (v 1 -2 -3 4))
(funcall (outer-product #'.=) (v 1 2 3 4) (v 1 -2 -3 4))
(funcall (outer-product #'.*) (v 10 20) (reshape (v 2 3) (v 1 2 3 4 5 6)))
(funcall (outer-product #'.*) (reshape (v 2 3) (v 1 2 3 4 5 6)) (v 10 20))

