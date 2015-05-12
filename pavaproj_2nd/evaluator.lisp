(defclass tensor ()
  ((lst 		:accessor tensor-lst
				:initform '(1 2 3)
				:initarg :lst)
   (randomarg 	:accessor tensor-arg
				:initform 10
				:initarg :randomarg)))

(defun make-tensor (lst)
  (make-instance 'tensor :lst lst))	

(defgeneric lst (tensorlist))

(defmethod lst ((tensorlist tensor))
  (slot-value tensorlist 'lst))
  
(defgeneric (setf lst) (value tensorlist))

(defmethod (setf lst) (value (tensorlist tensor))
  (setf (slot-value tensorlist 'lst) value))

  
(defun apl (expr)
    (eval expr))

(defun s (number)
     (make-tensor (list number)))

(defun v (&rest args)
    (make-tensor args))
	
(defun .- ((tensorlist tensor))
				
    (mapcar #'- (lst tensorlist)))





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