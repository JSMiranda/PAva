(defun tally (tt)
	(funcall (fold #'.*) (shape tt)))

(defun rank (tt)
	(funcall (fold #'+) (.<= (s 0) (shape tt))))