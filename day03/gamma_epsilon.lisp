(load "~/quicklisp/setup.lisp")
(ql:quickload :alexandria)
(ql:quickload "uiop")

(defun count-for-index (i compare)
  (setq zero 0)
  (setq ones 0)
  (loop for r in (uiop:read-file-lines "input.txt")
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

(defun generate-integer (ls)
  (parse-integer 
   (reduce (lambda (a i)
	     (setf a (concatenate 'string a (write-to-string i))))
	   ls
	   :initial-value "")
   :radix 2))

(setf gamma
      (generate-integer
       (loop for x in '(0 1 2 3 4 5 6 7 8 9 10 11)
	    collect (count-for-index x #'>))))

(setf epsilon
      (generate-integer
       (loop for x in '(0 1 2 3 4 5 6 7 8 9 10 11)
	    collect (count-for-index x #'<))))

(* gamma epsilon)
