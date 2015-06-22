(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(.+ (reshape (v 2 3) (v 1 2 -3 -4 5)) (reshape (v 2 3) (v 10 -20 30 -40 50)))
(.- (reshape (v 2 3) (v 1 2 -3 -4 5)) (reshape (v 2 3) (v 10 -20 30 -40 50)))
(.* (reshape (v 2 3) (v 1 2 -3 -4 5)) (reshape (v 2 3) (v 10 -20 30 -40 50)))
(./ (reshape (v 2 3) (v 1 2 -3 -4 5)) (reshape (v 2 3) (v 10 -20 30 -40 50)))
(.< (reshape (v 3 3) (v 1 2 -3 -4 5)) (reshape (v 3 3) (v 2 2 -4 2 3)))
(.> (reshape (v 3 3) (v 1 2 -3 -4 5)) (reshape (v 3 3) (v 2 2 -4 2 3)))
(.<= (reshape (v 3 3) (v 1 2 -3 -4 5)) (reshape (v 3 3) (v 2 2 -4 2 3)))
(.>= (reshape (v 3 3) (v 1 2 -3 -4 5)) (reshape (v 3 3) (v 2 2 -4 2 3)))
(.= (reshape (v 3 3) (v 1 2 -3 -4 5)) (reshape (v 3 3) (v 2 2 -4 2 3)))

