(load "~/quicklisp/setup.lisp")
(ql:quickload :alexandria)
(ql:quickload "uiop")

(defun count-for-index-list (i compare ls)
  (setq zero 0)
  (setq ones 0)
  (loop for r in ls
	;; Get ith bit from list
	;; Increment either 0 or 1 counter
	do (progn
	     (setq v (- (nth i (map 'list #'char-code r)) 48))
	     (if (eq v 0)
		 (incf zero)
		 (incf ones))
	     )
	)
  ;; Compare and return 0 or 1 - whichever has larger count
  (if (funcall compare zero ones) 0 1)
  )

(defun count-for-index (i compare)
  (count-for-index-list i compare (uiop:read-file-lines "input.txt")))

(defun generate-integer (ls)
  (parse-integer 
   (reduce (lambda (a i)
	     (setf a (concatenate 'string a (write-to-string i))))
	   ls
	   :initial-value "")
   :radix 2))

;; Iterate bit by bit
;; For each bit
;; Remove any numbers of the list where nth doesn't match the most common
(defun calc-oxygen ()
  (setf ls (uiop:read-file-lines "input.txt"))
  (loop for x in '(0) ;; 1 2 3 4 5 6 7 8 9 10 11)
	do (progn
	     (let ((common (count-for-index x #'>)))
	       (format t "~a~%" common)
	       (setf ls (remove-if-not
			 (lambda (q)
			   (progn (format t "~a ~a ~a~%" common (- (nth x (map 'list #'char-code q)) 48) (eql common (nth x (map 'list #'char-code q))))
				  (= common (nth x (map 'list #'char-code q)))))
			 ls)))))
  (format t "~a~%" ls)
  )

(setf oxygen
	
      (loop for x in '(0 1 2 3 4 5 6 7 8 9 10 11)
	    collect (count-for-index x #'>)))
	    ;; collect (remove-if-not (
	    ;; do (print x)))

(setf gamma
      (generate-integer
       (loop for x in '(0 1 2 3 4 5 6 7 8 9 10 11)
	    collect (count-for-index x #'>))))

(setf epsilon
      (generate-integer
       (loop for x in '(0 1 2 3 4 5 6 7 8 9 10 11)
	    collect (count-for-index x #'<))))

