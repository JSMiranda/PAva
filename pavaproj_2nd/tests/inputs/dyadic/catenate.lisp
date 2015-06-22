(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(catenate (s 2) (s 4))
(catenate (v 1 2) (v 3 4))
(catenate (v 1 2) (v 3 4 5 6))
(catenate (reshape (v 2 2) (v 1 2 3 4)) (reshape (v 2 2) (v 1 2 3 4 5 6)))
(catenate (reshape (v 2 2) (v 1 2 3 4)) (reshape (v 2 4) (v 1 2 3 4 5 6 7 8)))

