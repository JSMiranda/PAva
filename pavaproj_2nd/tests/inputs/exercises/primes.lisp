(locally
    (declare #+sbcl(sb-ext:muffle-conditions style-warning))
  (handler-bind
      (#+sbcl(style-warning #'muffle-warning))
    (load "load.lisp")
    ))
(primes (s 17))
(primes (s 20))
(primes (s 37))
(primes (s 50))
(primes (s 100))
(primes (s 1000))

