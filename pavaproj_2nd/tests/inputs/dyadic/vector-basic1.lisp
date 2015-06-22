(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(.+ (v 1 2 -3 -4 5) (v 10 -20 30 -40 50))
(.- (v 1 2 -3 -4 5) (v 10 -20 30 -40 50))
(.* (v 1 2 -3 -4 5) (v 10 -20 30 -40 50))
(./ (v 1 2 -3 -4 5) (v 10 -20 30 -40 50))
(.< (v 1 2 -3 -4 5) (v 2 2 -4 2 3))
(.> (v 1 2 -3 -4 5) (v 2 2 -4 2 3))
(.<= (v 1 2 -3 -4 5) (v 2 2 -4 2 3))
(.>= (v 1 2 -3 -4 5) (v 2 2 -4 2 3))
(.= (v 1 2 -3 -4 5) (v 2 2 -4 2 3))

