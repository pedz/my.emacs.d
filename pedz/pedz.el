;; (eval-when 'compile
;;   (add-to-list 'load-path (concat (file-name-directory byte-compile-current-file)
;; 				  "../el-get/helm")))
(put 'eval-expression 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; real apropos
(define-key help-map (kbd "a") 'apropos)

;; unset level so shell's prompt says "1"
(setenv "level" nil)

(defun backward-kill-line ()
  "Kills the line from point back to the beginning of the line"
  (interactive)
  (kill-line 0))

;; setup minibuffer maps to have BSD style TTY line editing
;; Removed while playing with Helm
;; (dolist (tmap (list
;; 	       minibuffer-local-completion-map
;; 	       minibuffer-local-filename-completion-map
;; 	       minibuffer-local-isearch-map
;; 	       minibuffer-local-map
;; 	       minibuffer-local-must-match-map
;; 	       minibuffer-local-ns-map
;; 	       minibuffer-local-shell-command-map))
;;   (define-key tmap "\C-w" 'backward-kill-word)
;;   (define-key tmap "\C-u" 'backward-kill-line))

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
(define-key personal-map (kbd "C-b")
  (function
   (lambda ()
     (interactive) (recenter -1))))
(define-key personal-map (kbd "C-f") 'auto-fill-mode)
(define-key personal-map (kbd "C-p") 'insert-current-pmr)
(define-key personal-map (kbd "C-g") 'goto-line)
(define-key personal-map (kbd "C-k") 'compile)
(define-key personal-map (kbd "C-v") 'view-file)
(define-key personal-map (kbd "b") 'bury-buffer)
(define-key personal-map (kbd "t") (function
                              (lambda ()
                                (interactive)
                                (recenter 0))))
(define-key personal-map (kbd "C-t") (function
                                 (lambda ()
                                   (interactive)
                                   (recenter 0))))
(define-key personal-map (kbd "l") 'list-all-matching-lines)
(define-key personal-map (kbd "C-c") 'toggle-buffer-case-fold-search)
(define-key personal-map (kbd "W") 'whitespace-cleanup)
(define-key personal-map (kbd "w") 'compare-windows)
(define-key personal-map (kbd "C-w") 'compare-windows)

(define-key global-map (kbd "C-\\") personal-map)

(defun list-all-matching-lines (regexp &optional nlines)
  (interactive "sList lines matching regexp: \nP")
  (let ((here (point)))
    (goto-char (point-min))
    (occur regexp nlines)
    (goto-char here)))

(define-key global-map (kbd "C-x C-b") 'electric-buffer-list)

(server-start)

(declare-function setup-x "x-stuff" ())
(if (or (eq window-system 'x)
        (eq window-system 'ns))
    (progn
      (require 'x-stuff)
      (setup-x)))

;; This is no longer needed / wanted.  I use to have the meta key the
;; same as the command key next to the space bar.  But that was
;; inconsistent with how the Terminal worked and that affected me
;; using zsh.  So now I have meta as Option which is more normal.
;; Note that for a Windows style keyboard, I still need to go into
;; Apple => System Preferences => Keyboard => Modifier Keys... and
;; rearrange the "Windows" key but I don't need to do anything for an
;; Apple keyboard such as one on a Mac laptop.
;;
;; (if (eq window-system 'ns)
;;     (progn
;;       (define-key global-map [?\M-h] 'ns-do-hide-emacs)
;;       (define-key global-map [?\M-\s-h] 'ns-do-hide-others)))

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

;; (eval-when-compile (defvar grep-files-aliases))
;; (eval-after-load 'grep
;;   '(add-to-list 'grep-files-aliases (cons "rails" "*.rb *.erb *.js *.css *.scss")))

(define-key global-map (kbd "C-x /") 'point-to-register)
(define-key global-map (kbd "C-x j") 'jump-to-register)

;; Add shift-<arrow key> to move between windows
;; (windmove-default-keybindings)


;;; which hack to show red colors that snapper puts out.
(defun display-ansi-colors ()
  (interactive)
  (require 'ansi-color)
  (ansi-color-apply-on-region (point-min) (point-max)))


;;; ;;; Setup doxymacs for Magicbook.
;;; ;;
;;; ;; We assume that if /usr/local/share/emacs/site-lisp exists then we
;;; ;; want to set up to use doxymacs for all C files.
;;; 
;;; (if (file-directory-p "/usr/local/share/emacs/site-lisp")
;;;     (progn
;;;       (declare-function doxymacs-mode "doxymacs"  (&optional arg))
;;;       (declare-function doxymacs-font-lock "doxymacs" nil)
;;;       (autoload 'doxymacs-mode "doxymacs"
;;; 	"Minor mode for using/creating Doxygen documentation.
;;; To submit a problem report, request a feature or get support, please
;;; visit doxymacs' homepage at http://doxymacs.sourceforge.net/.
;;; 
;;; To see what version of doxymacs you are running, enter
;;; `\\[doxymacs-version]'.
;;; 
;;; In order for `doxymacs-lookup' to work you will need to customise the
;;; variable `doxymacs-doxygen-dirs'.
;;; 
;;; Key bindings:
;;; \\{doxymacs-mode-map}" t)
;;;       (autoload 'doxymacs-font-lock "doxymacs"
;;; 	"Turn on font-lock for Doxygen keywords.")
;;;       (add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
;;;       (add-hook 'c-mode-common-hook 'doxymacs-mode)
;;;       (defun my-doxymacs-font-lock-hook ()
;;; 	(if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;; 	    (doxymacs-font-lock)))
;;;       (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)))
;;; 
(require 'url)

(if (and
     (fboundp 'mac-event-ae)
     (fboundp 'mac-ae-text)
     (fboundp 'mac-resume-apple-event))
    (defun mac-ae-get-url (event)
      "Open the URL specified by the Apple event EVENT.
Currently the `mailto' and `txmt' schemes are supported."
      (interactive "e")
      (let* ((ae (mac-event-ae event))
	     (the-text (mac-ae-text ae))
	     (parsed-url (url-generic-parse-url the-text))
	     (the-url-type (url-type parsed-url)))
	(cl-case (intern the-url-type)
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
  )


;;;### (autoloads (prvm-activate) "prvm" "prvm.el" (21138 27996 0
;;;;;;  0))
;;; Generated autoloads from prvm.el

(autoload 'prvm-activate "prvm" "\
Call this to find the .prvmrc file and set emacs's environment up
  to match

\(fn)" t nil)

;;;***

(defun rgrep-exclude-log-files ()
  "Add *.log to `grep-find-ignored-files'"
  (interactive)
  (add-to-list 'grep-find-ignored-files "*.log"))

(defun rgrep-include-log-files ()
  "Remove *.log from `grep-find-ignored-files'"
  (interactive)
  (setq grep-find-ignored-files (delete "*.log" grep-find-ignored-files)))

(defun rgrep-exclude-molecule-files ()
  "Add \"molecule\" to `grep-find-ignored-directories'"
  (interactive)
  (add-to-list 'grep-find-ignored-directories "molecule"))

(defun rgrep-include-molecule-files ()
  "Remove \"molecule\" from `grep-find-ignored-directories'"
  (interactive)
  (setq grep-find-ignored-directories (remove "molecule" grep-find-ignored-directories)))

(defun rgrep-exclude-node_modules-files ()
  "Add \"node_modules\" to `grep-find-ignored-directories'"
  (interactive)
  (add-to-list 'grep-find-ignored-directories "node_modules"))

(defun rgrep-include-node_modules-files ()
  "Remove \"node_modules\" from `grep-find-ignored-directories'"
  (interactive)
  (setq grep-find-ignored-directories (remove "node_modules" grep-find-ignored-directories)))

(defun rgrep-exclude-cache-files ()
  "Add \"cache\" to `grep-find-ignored-directories'"
  (interactive)
  (add-to-list 'grep-find-ignored-directories "cache"))

(defun rgrep-include-cache-files ()
  "Remove \"cache\" from `grep-find-ignored-directories'"
  (interactive)
  (setq grep-find-ignored-directories (remove "cache" grep-find-ignored-directories)))



(defun unfill ()
  "Does the opposite of fill.  Lines separated with a single new line
  are joined with a single space."
  (interactive)
  (replace-regexp "\\(.\\)\n\\(.\\)" "\\1 \\2"))

;;; Set Mac type default
(global-set-key "\M-`" 'other-frame)



(defun magit-repolist-column-url (_id)
  (let* ((map (make-sparse-keymap))
	 (branch (magit-get-current-branch))
	 (remote (magit-get "branch" branch "remote"))
	 (fork (magit-get-push-remote branch))
	 temp1 temp2 temp3 temp4 url)
    (if (null (or fork remote))
	"------"
      (setq temp1 (magit-get "remote" (or fork remote) "url")
	    temp2 (replace-regexp-in-string ":" "/" temp1)
	    temp3 (replace-regexp-in-string "git@" "https://" temp2)
	    temp4 (replace-regexp-in-string "\\.git" "" temp3)
	    url (format "%s/tree/%s" temp4 branch))
      (define-key map (kbd "<mouse-2>")
	`(lambda ()
	   (interactive)
	   (browse-url ,url)))
      (propertize "url =>"
		  'mouse-face 'highlight
		  'help-echo (format "visit %s" url)
		  'keymap map))))

(defun zsh-manpage-search-regexp (string &optional lax)
  "Returns a string to search for entries in the zshall man page"
  (format "\n[A-Z ]*\n \\{7\\}%s%s" string (if lax "" "\\_>")))

(isearch-define-mode-toggle zsh-manpage "z" zsh-manpage-search-regexp "\
Searching zshall man page for where a concept is described")

(eval-when-compile (add-to-list 'load-path (expand-file-name ".")))
; (require 'ruby-setup)
(provide 'pedz)
