(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(funcall (scan #'.+) (v 1 2 3 4 5))
(funcall (scan #'.+) (v 1 2 -3 -4 5))
(funcall (scan #'.*) (v 1 2 3 4 5))
(funcall (scan #'.*) (v 1 2 -3 -4 5))
(funcall (scan #'.or) (v 0 0 1 0 1))
(funcall (scan #'.or) (v 0 0 0 0 0))
(funcall (scan #'.and) (v 1 1 1 1 1))
(funcall (scan #'.and) (v 1 1 1 0 1))

