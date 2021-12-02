
(defvar input-file "input.txt")
(defvar count 0)
(defvar depths (list))

(defun read-file-as-lines (filename)
  "Read file into a list of lines."
  (with-open-file (in filename)
    (loop for line = (read-line in nil nil)
      while line
      collect line)))

(setq depths (loop for d in (read-file-as-lines input-file)
		     collect (parse-integer d)))

(setq count 0)
(loop for d in depths
      for x from 1

      when (> x 1)
	if (> d last-depth)
	  do (setq count (+ 1 count))
      do (setq last-depth d)
)
(format t "Increase count : ~d" count)
		
