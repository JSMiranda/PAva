(defun tally (tt)
	(funcall (fold #'.*) (shape tt)))
	
(defun rank (tt)
	(shape (shape tt)))
	
(defun within (vv n1 n2)

	(select  (.and (.<= n1 vv) (.>= n2 vv)) vv))



(defun ravel (tt)
(reshape (catenate (s 1) (funcall (fold #'.*) (shape tt))) tt))


#|
(defun primes (ss))
;(primes (s 50))
;2 3 5 7 11 13 17 19 23 29 31 37 41 43 47

|#





