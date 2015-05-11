(defun apl (expr)
    (eval expr))

(defun s (number)
    number)

(defun v (&rest args)
    args)
    
(defun .- (tensor)
    (mapcar #'- tensor))
    
(defun ./ (tensor)
    (mapcar #'/ tensor))
    
(defun .! (tensor)
    (mapcar #'fact tensor))
    
(defun fact (n)
  (if (< n 2)
      1
    (* n (fact(- n 1)))))
    
(defun .sin (tensor)
    (mapcar #'sin tensor))
    
(defun .cos (tensor)
    (mapcar #'cos tensor))
    
(defun .not (tensor)
    (mapcar (lambda (val) (if (zerop val)
                              0
                              1))
            tensor))
                                        


#|
    
(defun .* (tensor)
    (mapcar #'* tensor))
  
(defun ./ (tensor)
    (mapcar #'/ tensor))
    
(defun .// (tensor)
    (mapcar #'// tensor))
    
(defun .- (tensor)
    (mapcar #'- tensor))
    
(defun .% (tensor)
    (mapcar #'% tensor))
    
(defun .< (tensor)
    (mapcar #'< tensor))

|#