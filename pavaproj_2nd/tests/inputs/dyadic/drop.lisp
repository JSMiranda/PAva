(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(drop (s 3) (v 1 2 3 4 5 6 7 8 9))
(drop (s 5) (v 1 2 3 4 5 6 7 8 9))
(drop (s -3) (v 1 2 3 4 5 6 7 8 9))
(drop (s -5) (v 1 2 3 4 5 6 7 8 9))
(drop (v 2 2) (reshape (v 4 4) (v 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))
(drop (v -2 2) (reshape (v 4 4) (v 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))
(drop (v 2 -2) (reshape (v 4 4) (v 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))
(drop (v -2 -2) (reshape (v 4 4) (v 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))

