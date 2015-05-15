(defun tally (tt)
	(funcall (fold #'.*) (shape tt)))
	
(defun rank (tt)
	(shape (shape tt)))
	
(defun within (vv n1 n2)

	(select  (.and (.<= n1 vv) (.>= n2 vv)) vv))


;(within (v 2 7 3 1 9 8 4 6 5) (s 5) (s 8))
;7 8 6 5


(defun ravel (tt)
(reshape (catenate (s 1) (funcall (fold #'.*) (shape tt))) tt))


;(ravel (reshape (v 2 3 4) (interval 10)))
;1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 1 2 3 4

#|
(defun primes (ss))
;(primes (s 50))
;2 3 5 7 11 13 17 19 23 29 31 37 41 43 47

|#





