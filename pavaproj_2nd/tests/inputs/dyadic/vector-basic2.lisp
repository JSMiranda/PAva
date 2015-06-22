(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(.// (v 1 2 -3 -4 5) (v 2 2 2 2 3))
(.% (v 1 2 -3 -4 5) (v 2 2 2 2 3))
(.or (v 1 1 0 0 0) (v 0 1 1 0 0))
(.and (v 1 1 0 0 0) (v 0 1 1 0 0))

