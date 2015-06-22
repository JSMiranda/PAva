(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(.// (reshape (v 3 2) (v 1 2 -3 -4 5)) (reshape (v 3 2) (v 2 2 2 2 3)))
(.% (reshape (v 3 2) (v 1 2 -3 -4 5)) (reshape (v 3 2) (v 2 2 2 2 3)))
(.or (reshape (v 3 2) (v 1 1 0 0 0)) (reshape (v 3 2) (v 0 1 1 0 0)))
(.and (reshape (v 3 2) (v 1 1 0 0 0)) (reshape (v 3 2) (v 0 1 1 0 0)))

