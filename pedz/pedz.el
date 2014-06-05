
(put 'eval-expression 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; real apropos
(define-key help-map "a" 'apropos)

(defun backward-kill-line ()
  "Kills the line from point back to the beginning of the line"
  (interactive)
  (kill-line 0))

;; setup minibuffer maps to have BSD style TTY line editing
(dolist (tmap (list
	       minibuffer-local-completion-map
	       minibuffer-local-filename-completion-map
	       minibuffer-local-isearch-map
	       minibuffer-local-map
	       minibuffer-local-must-match-map
	       minibuffer-local-ns-map
	       minibuffer-local-shell-command-map))
  (define-key tmap "\C-w" 'backward-kill-word)
  (define-key tmap "\C-u" 'backward-kill-line))

;;
;; toggle the case fold search flag
;;
(defun toggle-buffer-case-fold-search ()
  "Toggles the case fold search flag for the local buffer"
  (interactive)
  (message "case-fold-search is now %s"
           (prin1-to-string (setq case-fold-search (not case-fold-search)))))

;;
;; My own map of things is in this map and I hook the map to \C-\\ for now
;;
(defvar personal-map (make-sparse-keymap)
  "Keymap for all personal key bindings")
(define-key personal-map "\C-b"
  (function
   (lambda ()
     (interactive) (recenter -1))))
(define-key personal-map "\C-f" 'auto-fill-mode)
(define-key personal-map "\C-p" 'insert-current-pmr)
(define-key personal-map "\C-g" 'goto-line)
(define-key personal-map "\C-k" 'compile)
(define-key personal-map "\C-v" 'view-file)
(define-key personal-map "b" 'bury-buffer)
(define-key personal-map "t" (function
                              (lambda ()
                                (interactive)
                                (recenter 0))))
(define-key personal-map "\C-t" (function
                                 (lambda ()
                                   (interactive)
                                   (recenter 0))))
(define-key personal-map "l" 'list-all-matching-lines)
(define-key personal-map "\C-c" 'toggle-buffer-case-fold-search)

(define-key global-map "\C-\\" personal-map)

(defun list-all-matching-lines (regexp &optional nlines)
  (interactive "sList lines matching regexp: \nP")
  (let ((here (point)))
    (goto-char (point-min))
    (occur regexp nlines)
    (goto-char here)))

(define-key global-map "\C-x\C-b" 'electric-buffer-list)

(server-start)

(declare-function setup-x "x-stuff" ())
(if (or (eq window-system 'x)
        (eq window-system 'ns))
    (progn
      (require 'x-stuff)
      (setup-x)))

(if (eq window-system 'ns)
    (progn
      (define-key global-map [?\M-h] 'ns-do-hide-emacs)
      (define-key global-map [?\M-\s-h] 'ns-do-hide-others)))

(display-time)

(defun unix-find ( dir &optional filter dont-add-self)
  "Acts similar to the unix find command.  Starting from DIR,
  recursively descends the file system calling FILTER.  Returns a list
  of file entries like directory-files-and-attributes returns.  FILTER
  is called with each file entry.  If it returns true, the file entry
  is added to the list that is returned.  This is a recursive
  function.  A third argument, if false, tests and adds DIR to the
  result list. FILTER defaults to t (return all files)"
  ;; Copyright Perry Smith, 2007
  ;; Aug 19, 2007

  ;; Default filter is to return everything
  (unless filter
    (setq filter (function (lambda (file) t))))
  
  ;; Set result to dir plus its attributes if appropriate
  (let* ((temp-file (unless dont-add-self
		      (cons dir (file-attributes dir))))
	 (result (unless (or dont-add-self
			     (not (funcall filter temp-file)))
		   (list temp-file))))

    ;; For each file in the directory, we call the lambda function
    (mapc
     (function (lambda (file)
		 ;; pick out file-name and is-dir.  Create full-name
		 ;; which is "dir/file-name"
		 (let* ((file-name (nth 0 file))
			(full-name (concat dir "/" file-name))
			(is-dir (nth 1 file)))

		   ;; for . and .. we do nothing
		   (unless (or (string-equal file-name ".")
			       (string-equal file-name ".."))

		     ;; call filter to see if file should be added to
		     ;; the result list.  We add a modified version of
		     ;; file by changing the file name to be the full
		     ;; path relative to the origin.
		     (if (funcall filter file)
			 (setq result (cons (cons full-name 
						  (cdr file))
					    result)))

		     ;; If file is a directory, recursively call
		     ;; ourselves.  We pass t as the third argument
		     ;; because we have already added this file to the
		     ;; result list.  We append what the recursive
		     ;; calls returns with the results we have so far.
		     (if is-dir
			 (setq result (append result
					      (unix-find full-name filter t))))))))
     (directory-files-and-attributes dir nil nil t))
    ;; return the result
    result))

(eval-after-load 'grep
  '(add-to-list 'grep-files-aliases (cons "rails" "*.rb *.erb *.js *.css *.scss")))

(define-key global-map "\C-x/" 'point-to-register)
(define-key global-map "\C-xj" 'jump-to-register)

;; Add shift-<arrow key> to move between windows
(windmove-default-keybindings)


(require 'url)

(defun mac-ae-get-url (event)
  "Open the URL specified by the Apple event EVENT.
Currently the `mailto' and `txmt' schemes are supported."
  (interactive "e")
  (let* ((ae (mac-event-ae event))
	 (the-text (mac-ae-text ae))
	 (parsed-url (url-generic-parse-url the-text))
	 (the-url-type (url-type parsed-url)))
    (case (intern the-url-type)
      (mailto
       (progn
	 (url-mailto parsed-url)
	 (select-frame-set-input-focus (selected-frame))))
      (txmt
       (let* ((not-used (string-match "txmt://open\\?url=file://\\([^&]*\\)\\(&line=\\([0-9]*\\)\\)?" the-text))
	      (file-name (match-string 1 the-text))
	      (lineno (match-string 3 the-text)))
	 (if (null file-name)
	     (message "Bad txmt URL: %s" the-text)
	   (find-file file-name)
	   (goto-char (point-min))
	   (if lineno
	       (forward-line (1- (string-to-number lineno))))
	   (select-frame-set-input-focus (selected-frame)))))
      (t (mac-resume-apple-event ae t)))))


;;;
;;; Rules to help with alignments in Ruby mode
;;;
(defvar align-rules-list)
(eval-after-load 'align
  '(dolist (ar '((ruby-migration-column-names
		  (regexp . "\\s-*t\\.\\(\\s_\\|\\sw\\)+\\( +\\)")
		  (group . 2)
		  (column . 20)
		  (separate . "\\<\\(do\\|end\\)\\>")
		  (modes . (list 'ruby-mode))
		  )
		 (ruby-migration-column-attributes
		  (regexp . ",\\(\\s-+\\)")
		  (repeat . t)
		  (modes . (list 'ruby-mode))
		  )
		 )) (add-to-list 'align-rules-list ar t)))


;;;### (autoloads (prvm-activate) "prvm" "prvm.el" (21138 27996 0
;;;;;;  0))
;;; Generated autoloads from prvm.el

(autoload 'prvm-activate "prvm" "\
Call this to find the .prvmrc file and set emacs's environment up
  to match

\(fn)" t nil)

;;;***

(provide 'pedz)
