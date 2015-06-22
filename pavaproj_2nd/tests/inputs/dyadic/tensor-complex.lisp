(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(drop (v 1 1 0) (reshape (v 2 2 2 3) (v 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))
(catenate (reshape (v 2 2 2) (v 1 2 3 4 5 6 7 8)) (reshape (v 2 2 4) (v 10 20 30 40 50 60 70)))
(member? (reshape (v 2 3 2 4) (v 1 2 3 4 5 6 7 8 9 10 11 12)) (v 1 2 3 4 7 11 12))
(select (v 1 0 0 1) (reshape (v 2 3 2 4) (v 1 2 3 4 5 6 7 8 9 10 11 12)))

