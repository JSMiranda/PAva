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
(defun monadic (op arg)
    (mapcar op (lst arg)))
 
(defgeneric .! (tens)
    (:method ((tens tensor))
        (monadic 'fact tens)))
 
(defgeneric .sin (tens)
    (:method ((tens tensor))
        (monadic 'sin tens)))
 
(defgeneric .cos (tens)
    (:method ((tens tensor))
        (monadic 'cos tens)))
 
(defgeneric .not (tens)
    (:method ((tens tensor))
        (monadic (lambda (val) (if (zerop val)
                              0
                              1)) tens)))
 
(defgeneric shape (tens)
    (:method ((tens tensor))
        (let ((res nil))
             (make-vect (invert-first-and-second (shape-aux (lst tens) res))))))

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
    
    

(defgeneric .+ (t1 t2))
    
(defmethod .+ ((v1 vect) (v2 vect))
    (dyadic #'+ v1 v2))
    
(defmethod .+ ((vv vect) (ss scalar))
    (dyadic #'+ vv ss))

(defmethod .+ ((ss scalar) (vv vect))
    (dyadic #'+ ss vv))

(defmethod .+ ((s1 scalar) (s2 scalar))
    (dyadic #'+ s1 s2))
    
    
(defgeneric .* (t1 t2))
    
(defmethod .* ((v1 vect) (v2 vect))
    (dyadic #'* v1 v2))
    
(defmethod .* ((vv vect) (ss scalar))
    (dyadic #'* vv ss))

(defmethod .* ((ss scalar) (vv vect))
    (dyadic #'* ss vv))

(defmethod .* ((s1 scalar) (s2 scalar))
    (dyadic #'* s1 s2))
    
    
(defgeneric .// (t1 t2))
    
(defmethod .// ((v1 vect) (v2 vect))
    (dyadic #'truncate v1 v2))
    
(defmethod .// ((vv vect) (ss scalar))
    (dyadic #'truncate vv ss))

(defmethod .// ((ss scalar) (vv vect))
    (dyadic #'truncate ss vv))

(defmethod .// ((s1 scalar) (s2 scalar))
    (dyadic #'truncate s1 s2))
    
    
(defgeneric .% (t1 t2))
    
(defmethod .% ((v1 vect) (v2 vect))
    (dyadic #'rem v1 v2))
    
(defmethod .% ((vv vect) (ss scalar))
    (dyadic #'rem vv ss))

(defmethod .% ((ss scalar) (vv vect))
    (dyadic #'rem ss vv))

(defmethod .% ((s1 scalar) (s2 scalar))
    (dyadic #'rem s1 s2))


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