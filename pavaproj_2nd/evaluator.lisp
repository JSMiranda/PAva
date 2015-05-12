(defclass tensor ()
  ((lst 		:accessor lst
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
	
	;;;;;;MONADIC;;;;;;
    
(defun .- ((t1 tensor))
    (mapcar #'- (lst t1)))
    
(defun ./ ((t1 tensor))
    (mapcar #'/ (lst t1)))
    
(defun .! ((t1 tensor))
    (mapcar #'fact (lst t1)))
    
(defun fact (n)
  (if (< n 2)
      1
    (* n (fact(- n 1)))))
    
(defun .sin ((t1 tensor))
    (mapcar #'sin (lst t1)))
    
(defun .cos ((t1 tensor))
    (mapcar #'cos (lst t1)))
    
(defun .not ((t1 tensor))
    (mapcar (lambda (val) (if (zerop val)
                              0
                              1))
            (lst t1)))
                         
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
			(setf res (append res (list (+ 1 count)))))
		(make-tensor res)))

;;;;;;DYADIC;;;;;;;
(defun .+ ((tensor1 tensor) (tensor2 tensor))
	(let ((res nil))
	(cond 	((= (length (lst tensor1))(length (lst tensor2)))
				(dotimes (count (length (lst tensor1)))
					(setf res (append res (list (+ (nth count (lst tensor1)) (nth count(lst tensor2))) )))))
			((= 1 (length (lst tensor1)))
				(dotimes (count (length (lst tensor2)))
					(setf res (append res (list (+ (nth 0 (lst tensor1)) (nth count (lst tensor2))))))))
			((= 1 (length (lst tensor2)))
				(dotimes (count (length (lst tensor1)))
					(setf res (append res (list (+ (nth 0 (lst tensor2)) (nth count (lst tensor1))))))))
			(t (princ "tensors not of the same size")))
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