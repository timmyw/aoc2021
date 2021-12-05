(load "~/quicklisp/setup.lisp")
(ql:quickload "uiop")

(defvar input-file "input.txt")

(setq directions
      (mapcar (lambda (line) (uiop:split-string line :separator " "))
	      (uiop:read-file-lines "input.txt")))

(progn
  (setq horiz 0)
  (setq vert 0)
  (mapcar (lambda (x)
	    (progn
	      (setq val (parse-integer (car (cdr x))))
	      (cond
		((equal (car x) '"forward") (setq horiz (+ horiz val)))
		((equal (car x) '"down") (setq vert (+ vert val)))
		((equal (car x) '"up") (setq vert (- vert val))))
	    ))
	  directions)
  (format t "~d ~d~%" horiz vert)
  (format t "~d~%" (* horiz vert))
  )

;; Day 2

(progn
  (setq horiz 0)
  (setq vert 0)
  (setq aim 0)
  (mapcar (lambda (x)
	    (progn
	      (setq val (parse-integer (car (cdr x))))
	      (cond
		((equal (car x) '"forward")
		 (progn
		   (setq vert (+ vert (* aim val)))
		   (setq horiz (+ horiz val))))
		((equal (car x) '"down") (setq aim (+ aim val)))
		((equal (car x) '"up") (setq aim (- aim val))))
	    ))
	  directions)
  (format t "~d ~d~%" horiz vert)
  (format t "~d~%" (* horiz vert))
  )
