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


;;;
;;; Rule to stop using smie in Ruby mode.
;;;
(defvar ruby-use-smie nil)


;;; setup yari and yari-helm because it needs helm which I don't load
;;; usually
(defun yari-bind-key ()
  (require 'helm)
  (local-set-key [f1] 'yari-helm))

(add-hook 'ruby-mode-hook 'yari-bind-key)


;;; Set comment-auto-fill-only-comments as true and make it buffer
;;; local as well as turn auto-fill on.  We can then add this to mode
;;; specific hooks.
(defun auto-fill-comments ()
  "Sets `comment-auto-fill-only-comments` as buffer local, set it to
`t`, and calls `auto-fill-mode` with `t`.  This has the effect of
turning on auto fill mode within code comments only."
  (make-local-variable 'comment-auto-fill-only-comments)
  (setq comment-auto-fill-only-comments t)
  (auto-fill-mode t))

(add-hook 'ruby-mode-hook 'auto-fill-comments)


;;; Set up paragraph-separate and paragraph-start
;;; This may not be best now.  Need to experiment
(defun yard-paragraph-boundaries ()
  (interactive)
  ;; Paragraphs are separated by lines containing only a # character
  (setq paragraph-separate "[ \t]*#[ \t]*$")
  ;; Paragraphs start with YARD tags or list items
  (setq paragraph-start
	(concatenate
	 'string
	 "[ \t]*"		; some whitespace
	 "#[ \t]*"		; a # character followed by whitespace
	 "\\("
         "@[[:alpha:]]+"	; a YARD tag
	 "\\|"			; or
         "-"			; a list item
	 "\\)"
	 "\\([ \t]+.*\\)?"	; an optional text
	 "[ \t]*$")))		; some more whitespace

(add-hook 'ruby-mode-hook 'yard-paragraph-boundaries)



(provide 'ruby-setup)
