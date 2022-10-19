;;;
;;; This only defines new functions or variables and add hooks.  It
;;; does not change settings at load time and tries hard not to make
;;; any assumptions.  (e.g. is rbenv mode even present?)  So it should
;;; be safe to load all the time.
;;; 


;;;
;;; Rules to help with alignments in Ruby mode
;;;

;; (defvar align-rules-list)
;; (eval-after-load 'align
;;   '(dolist (ar '((ruby-migration-column-names
;; 		  (regexp . "\\s-*t\\.\\(\\s_\\|\\sw\\)+\\( +\\)")
;; 		  (group . 2)
;; 		  (column . 20)
;; 		  (separate . "\\<\\(do\\|end\\)\\>")
;; 		  (modes . (list 'ruby-mode))
;; 		  )
;; 		 (ruby-migration-column-attributes
;; 		  (regexp . ",\\(\\s-+\\)")
;; 		  (repeat . t)
;; 		  (modes . (list 'ruby-mode))
;; 		  )
;; 		 )) (add-to-list 'align-rules-list ar t)))


;;; Set comment-auto-fill-only-comments as true and make it buffer
;;; local as well as turn auto-fill on.  We can then add this to mode
;;; specific hooks.
;;
;; This looks useful but lets turn it off for now.
;;
;; (defun auto-fill-comments ()
;;   "Sets `comment-auto-fill-only-comments` as buffer local, set it to
;; `t`, and calls `auto-fill-mode` with `t`.  This has the effect of
;; turning on auto fill mode within code comments only."
;;   (make-local-variable 'comment-auto-fill-only-comments)
;;   (setq comment-auto-fill-only-comments t)
;;   (auto-fill-mode t))

;; (add-hook 'ruby-mode-hook 'auto-fill-comments)

;;; Set up paragraph-separate and paragraph-start
;;; This may not be best now.  Need to experiment
;;
;; Again, this looks useful but lets turn it off until I start doing
;; yard work (HAHAHAHAHA) again.
;;
;; (defun yard-paragraph-boundaries ()
;;   (interactive)
;;   ;; Paragraphs are separated by lines containing only a # character
;;   (setq paragraph-separate "[ \t]*#[ \t]*$")
;;   ;; Paragraphs start with YARD tags or list items
;;   (setq paragraph-start
;; 	(cl-concatenate
;; 	 'string
;; 	 "[ \t]*"		; some whitespace
;; 	 "#[ \t]*"		; a # character followed by whitespace
;; 	 "\\("
;;          "@[[:alpha:]]+"	; a YARD tag
;; 	 "\\|"			; or
;;          "-"			; a list item
;; 	 "\\)"
;; 	 "\\([ \t]+.*\\)?"	; an optional text
;; 	 "[ \t]*$")))		; some more whitespace
;; (add-hook 'ruby-mode-hook 'yard-paragraph-boundaries)
