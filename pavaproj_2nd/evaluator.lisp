(defclass tensor ()
  ((lst :accessor lst
	:initarg :lst)))

(defclass scalar (tensor)())

(defclass vect (tensor)())

(defun make-tensor (lst)
  (make-instance 'tensor :lst lst))
  
(defun make-scalar (lst)
  (make-instance 'scalar :lst lst))
  
(defun make-vect (lst)
  (make-instance 'vect :lst lst))

(defun s (number)
     (make-scalar (list number)))

(defun v (&rest args)
    (make-vect args))
		
;;;;;;MONADIC;;;;;;



(defgeneric monadic (op arg))

(defmethod monadic (op (vv vect))

	(make-vect (mapcar op (lst vv))))

(defmethod monadic (op(ss scalar))

	(make-scalar (mapcar op (lst ss))))

(defun .! (tensor)
        (monadic 'fact tensor))
 
(defun .sin (tensor)
    (monadic 'sin tensor))
 
(defun .cos (tensor)
    (monadic 'cos tensor))
 
(defun .not (tensor)
      (monadic (lambda (val) (if (zerop val)
                              0
                              1)) tensor))
 
(defun shape (tensor)
        (let ((res nil))
             (make-vect (invert-first-and-second (shape-aux (lst tensor) res)))))

;; Auxiliar functions
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
    
(defun fact (n)
  (if (< n 2)
      1
    (* n (fact(- n 1)))))
    
	
;;;;;;DYADIC;;;;;;
(defgeneric dyadic (op arg1 arg2))

(defmethod dyadic ((op function) (v1 vect) (v2 vect))
    (if (eq (length (lst v1)) (length (lst v2)))
        (let ((res nil)) (progn (dotimes (count (length (lst v1)))
                                         (setf res (append res (list (funcall op (nth count (lst v1)) (nth count(lst v2)))))))
                                (make-vect res)))
        (princ "error: tensors not of the same size")))

(defmethod dyadic ((op function) (vv vect) (ss scalar))
    (let ((res nil)) (progn (dotimes (count (length (lst vv)))
                                     (setf res (append res (list (funcall op (nth count (lst vv)) (nth 0 (lst ss)))))))
                            (make-vect res))))

(defmethod dyadic ((op function) (ss scalar) (vv vect))
    (let ((res nil)) (progn (dotimes (count (length (lst vv)))
                                     (setf res (append res (list (funcall op (nth 0 (lst ss)) (nth count (lst vv)))))))
                            (make-vect res))))
                            
(defmethod dyadic ((op function) (s1 scalar) (s2 scalar))
    (make-scalar (funcall op (car (lst s1)) (car (lst s2)))))

;;;;;;;;;;;;;;;;;;;;;


(defgeneric logical-dyadic (op arg1 arg2))
    
(defmethod logical-dyadic ((op function) (v1 vect) (v2 vect))
    (if (eq (length (lst v1)) (length (lst v2)))
        (let ((res nil)) (progn (dotimes (count (length (lst v1)))
                                         (if (funcall op (nth count (lst v1)) (nth count(lst v2)))
                                             (setf res (append res (list 1)))
                                             (setf res (append res (list 0)))))
                                (make-vect res)))
        (princ "error: tensors not of the same size")))

(defmethod logical-dyadic ((op function) (vv vect) (ss scalar))
    (let ((res nil)) (progn (dotimes (count (length (lst vv)))
                                     (if (funcall op (nth count (lst vv))(nth 0 (lst ss)))
                                         (setf res (append res (list 1)))
                                         (setf res (append res (list 0)))))
                            (make-vect res))))

(defmethod logical-dyadic ((op function) (ss scalar) (vv vect))
    (let ((res nil)) (progn (dotimes (count (length (lst vv)))
                                     (if (funcall op (nth 0 (lst ss)) (nth count (lst vv)))
                                         (setf res (append res (list 1)))
                                         (setf res (append res (list 0)))))
                            (make-vect res))))
                            
(defmethod logical-dyadic ((op function) (s1 scalar) (s2 scalar))
    (make-scalar (if (funcall op (car (lst s1)) (car (lst s2)))
                     '(1)
                     '(0))))
    
    
;;;;;;;;;;;;;;

(defun .+ (t1 t2)
  (dyadic #'+ t1 t2))

(defun .* (t1 t2)
 (dyadic #'* t1 t2))

(defun .// (t1 t2)
 (dyadic #'truncate t1 t2))

(defun .% (t1 t2)
 (dyadic #'rem t1 t2))

(defun .< (t1 t2)
 (logical-dyadic #'< t1 t2))

(defun .> (t1 t2)
 (logical-dyadic #'> t1 t2))

(defun .<= (t1 t2)
 (logical-dyadic #'<= t1 t2))
 
(defun .>= (t1 t2)
 (logical-dyadic #'>= t1 t2))

 (defun .= (t1 t2)
 (logical-dyadic #'eq t1 t2))
 
 (defun .or (t1 t2)
 (logical-dyadic (lambda (x y) (if (eq x 0) 
									(if (eq y 0)
									     nil
										 t)
									t)) t1 t2))
									
									
(defun .and (t1 t2)
 (logical-dyadic (lambda (x y) (cond ((eq x 0) nil)
									((eq y 0) nil)
									(t t))) t1 t2))
										
 
 
 

;;;;;;MONADIC & DYADIC;;;;;;
(defgeneric .- (t1 t2))
    
(defmethod .- ((v1 vect) (v2 vect))
    (dyadic #'- v1 v2))
    
(defmethod .- ((vv vect) (ss scalar))
    (dyadic #'- vv ss))

(defmethod .- ((ss scalar) (vv vect))
    (dyadic #'- ss vv))

(defmethod .- ((s1 scalar) (s2 scalar))
    (dyadic #'- s1 s2))
	
	
;; TODO: monadic com optional??

(defgeneric ./ (t1 t2))
    
(defmethod ./ ((v1 vect) (v2 vect))
    (dyadic #'/ v1 v2))
    
(defmethod ./ ((vv vect) (ss scalar))
    (dyadic #'/ vv ss))

(defmethod ./ ((ss scalar) (vv vect))
    (dyadic #'/ ss vv))

(defmethod ./ ((s1 scalar) (s2 scalar))
    (dyadic #'/ s1 s2))
;; TODO: monadic com optional??