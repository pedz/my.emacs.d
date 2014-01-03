(defvar favorite-colors (list "DarkSlateGray1"
			      "LavenderBlush2"
			      "LightBlue1"
			      "LightCyan2"
			      "LightSteelBlue1"
			      "LightYellow2"
			      "SlateGray1"
			      "bisque"
			      "bisque1"
			      "cornsilk2"
			      "gray90"
			      "honeydew2"
			      "seashell2"
			      "thistle2"
			      "wheat1")
  "List of my favorite background colors")

(defun pick-random-color ()
  "Picks a random color from favorite-colors"
  ;; currently set to just black...
  (or "black"
      (nth (random (length favorite-colors) favorite-colors))))

(defun x-alter-params ()
  "before-make-frame-hook is set to this so this is called before the
frame is created.  This function appends to parameters (the local
variable in make-frame) what ever things it wants to"
  (add-to-list 'parameters
	       (list (cons 'background-color (pick-random-color))) t))

(add-hook 'before-make-frame-hook 'x-alter-params)

(defun setup-x ()
  "Simple sequence to setup X for me"
  (setq baud-rate 1000000)		; don't recalc display on X
  (setq default-frame-alist
	(append 
	 '((minibuffer . t) (menu-bar-lines . 0))
	 (if (x-display-color-p)
	     (if nil
		 (list (cons 'background-color (pick-random-color))
		       (cons 'cursor-color "SlateBlue")
		       (cons 'foreground-color "black")
		       (cons 'mouse-color "Blue"))
	       (list (cons 'background-color "black")
		       (cons 'cursor-color "SlateBlue")
		       (cons 'foreground-color "grey")
		       (cons 'mouse-color "Blue")))
	   (list (cons 'background-color "black")
		 (cons 'cursor-color "white")
		 (cons 'foreground-color "white")
		 (cons 'mouse-color "grey"))))))
	   

(provide 'x-stuff)
