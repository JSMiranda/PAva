(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(funcall (fold #'.+) (v 1 2 3 4 5))
(funcall (fold #'.+) (v 1 2 -3 -4 5))
(funcall (fold #'.*) (v 1 2 3 4 5))
(funcall (fold #'.*) (v 1 2 -3 -4 5))
(funcall (fold #'./) (v 1 2 3 4 5))
(funcall (fold #'./) (v 1 2 -3 -4 5))
(funcall (fold #'.or) (v 1 1 0 0 1))
(funcall (fold #'.or) (v 0 0 0 0 0))
(funcall (fold #'.and) (v 1 1 1 1 1))
(funcall (fold #'.and) (v 1 0 0 1 1))

