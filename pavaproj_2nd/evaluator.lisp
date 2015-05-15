;;;;;;PAVA 2;;;;;;



;;;;;;ClASS DEFENITIONS/FUNCTIONS;;;;;;


(defclass tensor ()
  ((lst :accessor lst
	:initarg :lst)))

(defclass scalar (tensor)())

(defmethod print-object ((obj scalar) out)
    (format out "~s" (car (lst obj))))

(defclass vect (tensor)())

(defmethod print-object ((obj vect) out)
    (let ((dim (calculate-dimensions obj)))
        (cond ((eq dim 1) (format out "~{~a~^ ~}" (lst obj)))
              ((eq dim 2) (format out "~{~a~^~%~}" (lst obj)))
              ((> dim 2)  (format out (concatenate 'string "~{~a~^~" (write-to-string dim) "%~}") (lst obj))))))
			  

(defun make-tensor (lst)
  (make-instance 'tensor :lst lst))
  
(defun make-scalar (lst)
  (make-instance 'scalar :lst lst))
  
(defun make-vect (lst)
  (make-instance 'vect :lst lst))
  
(defun create-vect-from-big-list (lst)
     (make-vect (if (numberp (car lst))
                    lst
                    (let ((res nil))
                         (mapcar (lambda (x) (setf res (append res (lst (make-vect x))))) lst)
                         res))))

(defun s (number)
     (make-scalar (list number)))

(defun v (&rest args)
    (make-vect args))


	
	
;;;;;;MONADIC FUNCTIONS;;;;;;


;;;;;;TEMPLATES
(defgeneric monadic (op arg))

(defmethod monadic (op (vv vect))
        (reshape (shape vv) (make-vect (mapcar op (vect-to-list vv)))))
#|
    (if (numberp (car (lst vv)))
        (make-vect (mapcar op (lst vv)))
        (dolist (item (lst vv))
                (monadic op (lst item)))))
|#



(defmethod monadic (op (ss scalar))
	(make-scalar (mapcar op (lst ss))))
;;;;;;


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
    (make-vect (get-dimensions tensor)))

(defun shape-aux (tensor res-list)
    (if (listp tensor)
        (shape-aux (car tensor) (append (list (length tensor)) res-list))
        res-list))
    
 (defun interval (num)
	(let ((res nil))
	
	(dotimes (count num)
		(setf res (append res (list (+ count 1))))
		)
		(make-vect res)))
		
	
;;;;;;DYADIC;;;;;;

;;;;;;TEMPLATES
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
					 
;;;;;;



    
    
;;;;;;DYADIC FUNCTIONS;;;;;;

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
                                    


(defun reshape (vv tt)
    (let ((prevl nil)
          (currl nil)
          (dims (invert-first-and-second (lst vv)))
          (dims-mult 1)
          (vals (vect-to-list tt))
          (curr-index 0))
         ;; dims-mult = D2*D3*...*DN
         (dolist (item dims)
                 (setf dims-mult (* dims-mult item)))
         (setf dims-mult (/ dims-mult (first dims)))
         ;; creating a big and simple list out of the tensor
         (dotimes (i (* (first dims) dims-mult))
                  (setf currl (append currl (list (nth (rem curr-index (length vals)) vals))))
                  (incf curr-index))
         ;; creating the matrix
         (dolist (item dims)
                 (setf prevl currl)
                 (setf currl nil)
                 (dotimes (i (/ (length prevl) item))
                                    ; (format t "BEFORE:~%Prev: ~s~%Curr: ~s~%item = ~s~%" prevl currl item)
                          (setf currl (append (list (make-vect (last prevl item))) currl))
                          (nbutlast prevl item)
                                     ;(format t "AFTER: ~%Prev: ~s~%Curr: ~s~%" prevl currl)
                                     ))
         (make-vect currl)))


(defun vect-to-list (vv)
    (let ((res nil))
        (if (numberp (car (lst vv)))
            (setf res (lst vv))
            (dotimes (i (length (lst vv)))
                (setf res (append res (vect-to-list (nth i (lst vv)))))))
        res))
                                    
                                    
                                    
                                    
 ;only for 1dim tensors
 (defun catenate ( v1 v2)
	  (make-vect (append (lst v1) (lst v2))))
	  
(defgeneric drop (v t))

(defmethod drop ( (s scalar) (v vect))
	(let (
		(n (car(lst s)))
		(res (lst v)))
		
	
			
	
		(cond
	
			((< n 0)	(dotimes (count (* n (- 1)))
				
						(setf res (reverse (cdr (reverse res)))))
			)
					
			((> n 0) (dotimes (count n )
				
						(setf res (cdr res)))
			)
		
			(t res))
		(make-vect res)
	)		
)

#|v
(defmethod drop (( v vector) (v vect))
	;TODO
)

TODO
|#


;only for 1dim
(defun member? (tensor1 tensor2)
(let (
		(l1 (lst tensor1))
		(l2 (lst tensor2))
		(res (lst tensor1)))

		(dotimes (count (length l1))
			(if (find (nth count l1) l2)
				(setf (nth count res) 1)
				(setf (nth count res) 0))
	)
	(make-vect res))

)


;only for 1dim
(defun select( booltensor tensor)

		   
	(make-vect (select-rec (list)(lst booltensor) (lst tensor))))
	
	(defun select-rec (res boolt tl)
	
		(if (not boolt)
			res
			(if (eq (car boolt) 1)
				(select-rec  (append res (list(car tl))) (cdr boolt) (cdr tl))
				(select-rec res (cdr boolt) (cdr tl))			
			))
				)

;;;;;;MONADIC & DYADIC FUNCTIONS;;;;;;
                    
(defun .- (t1 &optional t2)
	(if (null t2)
		(monadic '- t1)
		(dyadic #'- t1 t2)))
		

(defun ./ (t1 &optional t2)
	(if (null t2)
		(monadic '/ t1)
		(dyadic #'/ t1 t2)))
		
		
;;;;;;MONADIC OPERATORS;;;;;;
;fold Accepts a function and returns another function that, given a vector, computes
;the application of the function to sucessive elements of the vector.

;scan Similar to fold but using increasingly large subsets of the elements of the
;vector, starting from a subset containing just the first element up to a
;subset containing all elements.

;outer-product Accepts a function and returns another functions that, given
;two tensors, returns a new tensor with the result of applying the function
;to every combination of values from the first and second tensors.


;(defun fold ())

;(defun scan ())

;(defun outer-product())



;;;;;;DYADIC OPERATORS;;;;;;

;inner-product Accepts two functions and returns a function that, given two
;tensors, returns a new tensor computed according to the rules of the algebraic
;inner product but replacing the algebraic sum and product with
;the first and second functions.

;(defun inner-product ())

	
;;;;;;AUXILIAR FUNCTIONS;;;;;;

(defun calculate-dimensions (vect)
    (if (numberp (car (lst vect)))
        1
        (1+ (calculate-dimensions (car (lst vect))))))
									
									
(defun invert-first-and-second (list-to-invert)
    (if (< (length list-to-invert) 2)
        list-to-invert
        (append (list (second list-to-invert))
                (list (first list-to-invert))
                (if (> (length list-to-invert) 2) ;; Prevents accessing null cdr
                    (cddr list-to-invert)))))

(defun get-dimensions (tensor)
    (invert-first-and-second (list-dim (lst tensor))))
                    
(defun list-dim (a-list)
    (if (numberp (car a-list))
        (list (length a-list))
	    (append (list-dim (lst (car a-list))) 		
				(if (eq (length a-list) 1)
					nil
					(list(length a-list)))
		)))
            
(defun fact (n)
  (if (< n 2)
      1
    (* n (fact(- n 1)))))
