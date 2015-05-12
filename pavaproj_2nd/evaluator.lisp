(defclass tensor ()
  ((lst 		:accessor tensor-lst
				:initform '(1 2 3)
				:initarg :lst)
   (randomarg 	:accessor randomarg
				:initform 10
				:initarg :randomarg)))

(defun make-tensor (lst)
  (make-instance 'tensor :lst lst))	

  
(defun apl (expr)
    (eval expr))

(defun s (number)
     (make-tensor (list number)))

(defun v (&rest args)
    (make-tensor args))
    
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
                         
(defun shape (tensor)
    (let ((res nil))
        (invert-first-and-second (shape-aux tensor res))))
        
(defun invert-first-and-second (list-to-invert)
    (if (< (length list-to-invert) 2)
        list-to-invert
        (append (list (second list-to-invert))
                (list (first list-to-invert))
                (if (> (length list-to-invert) 2) ;; Prevents accessing null cdr
                    (cddr list-to-invert)))))
            
(defun shape-aux (tensor res-list)
    (if (listp tensor)
        (shape-aux (car tensor) (append (list (length tensor)) res-list))
        res-list))
		
(defun interval (number)
	(let ((res nil))
        (dotimes (count number)
			(setf res (append res (list count))))
		(make-tensor res)))

#|

(shape '((((1 2 3) (4 5 1))
          ((1 2 3) (4 5 1)))
         (((1 2 3) (4 5 1))
          ((1 2 3) (4 5 1)))))

    
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