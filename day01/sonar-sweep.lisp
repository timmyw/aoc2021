
(defvar input-file "input.txt")
(defvar inc-count 0)
(defvar depths (list))
(defvar last-depth 0)

(defun read-file-as-lines (filename)
  "Read file into a list of lines."
  (with-open-file (in filename)
    (loop for line = (read-line in nil nil)
      while line
      collect line)))

(setq depths (loop for d in (read-file-as-lines input-file)
		     collect (parse-integer d)))

(setq inc-count 0)
(loop for d in depths
      for x from 1

      when (> x 1)
	if (> d last-depth)
	  do (setq inc-count (+ 1 inc-count))
      do (setq last-depth d)
)
(format t "Increase inc-count : ~d" inc-count)

(defun sum (l) (apply '+ l))

(progn
  (setq last-depth 0)
  (setq inc-count 0)
  (loop for (a b c) on depths
	while c
	do
	   (progn
	     (if (and (< 0 last-depth) (> (sum (list a b c)) last-depth))
		 (setq inc-count (+ 1 inc-count)))
	     (setq last-depth (sum (list a b c)))))
  (format t "Increase inc-count : ~d" inc-count))
