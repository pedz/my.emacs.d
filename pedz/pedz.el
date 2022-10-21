;; [[file:pedz.org::*Small tweaks][Small tweaks:1]]
(put 'downcase-region  'disabled nil)
(put 'eval-expression  'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region    'disabled nil)

(define-key help-map (kbd "A") 'apropos-command)
(define-key help-map (kbd "a") 'apropos)
;; Small tweaks:1 ends here

;; [[file:pedz.org::*Personal keymap][Personal keymap:1]]
(defun pedz/toggle-buffer-case-fold-search ()
  "Toggles the case fold search flag for the local buffer"
  (interactive)
  (message "case-fold-search is now %s"
           (prin1-to-string (setq case-fold-search (not case-fold-search)))))

(defun pedz/list-all-matching-lines (regexp &optional nlines)
  (interactive "sList lines matching regexp: \nP")
  (let ((here (point)))
    (goto-char (point-min))
    (occur regexp nlines)
    (goto-char here)))

(defun pedz/recenter-top ()
  "Redraw page with the current line at the top of the page"
  (interactive)
  (recenter 0))

(defun pedz/recenter ()
  "Redraw page with the current line in the middle of the page"
  (interactive)
  (recenter nil))

(defun pedz/recenter-bottom ()
  "Redraw page with the current line at the top of the page"
  (interactive)
  (recenter -1))

;;
;; My own keymap of key bindings is in this map and I hook the map to
;; \C-\\ for now
;;
(defvar pedz/personal-map (make-sparse-keymap)
  "Keymap for all personal key bindings")
(define-key pedz/personal-map (kbd "C-b") #'pedz/recenter-bottom)
(define-key pedz/personal-map (kbd "C-c") #'pedz/toggle-buffer-case-fold-search)
(define-key pedz/personal-map (kbd "C-f") #'auto-fill-mode)
(define-key pedz/personal-map (kbd "C-g") #'goto-line)
(define-key pedz/personal-map (kbd "C-k") #'compile)
(define-key pedz/personal-map (kbd "C-p") #'insert-current-pmr)
(define-key pedz/personal-map (kbd "C-t") #'pedz/recenter-top)
(define-key pedz/personal-map (kbd "C-v") #'view-file)
(define-key pedz/personal-map (kbd "C-w") #'compare-windows)
(define-key pedz/personal-map (kbd "W")   #'whitespace-cleanup)
(define-key pedz/personal-map (kbd "b")   #'bury-buffer)
(define-key pedz/personal-map (kbd "l")   #'pedz/list-all-matching-lines)
(define-key pedz/personal-map (kbd "t")   #'pedz/recenter-top)
(define-key pedz/personal-map (kbd "w")   #'compare-windows)

(define-key global-map (kbd "C-\\") pedz/personal-map)
(define-key global-map (kbd "C-x C-b") #'electric-buffer-list)
(define-key isearch-mode-map (kbd "C-\\") nil)
;; Personal keymap:1 ends here

;; [[file:pedz.org::*Server start][Server start:1]]
(server-start)
;; Server start:1 ends here

;; [[file:pedz.org::*Enable displaying the time in the mode lines][Enable displaying the time in the mode lines:1]]
(display-time)
;; Enable displaying the time in the mode lines:1 ends here

;; [[file:pedz.org::*Quicker point to register / register to point key bindings][Quicker point to register / register to point key bindings:1]]
(define-key global-map (kbd "C-x /") 'point-to-register)
(define-key global-map (kbd "C-x j") 'jump-to-register)
;; Quicker point to register / register to point key bindings:1 ends here

;; [[file:pedz.org::*Tab bar mode][Tab bar mode:1]]
(tab-bar-mode +1)
(global-set-key (kbd "s-}") #'tab-next)
(global-set-key (kbd "s-{") #'tab-previous)
;; Tab bar mode:1 ends here

;; [[file:pedz.org::*Old Carbon URL Processing][Old Carbon URL Processing:2]]
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

;;;
;;; Use to be part of x-stuff.el but I just removed the file and put
;;; what was useful here.
;;;

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
  (nth (random (length favorite-colors)) favorite-colors))

;; Lua mode
(defun add-lua-align-list ()
  "Adds patterns to `align-rules-list'"
  (add-to-list 'align-rules-list
             '(lua-eq
               (regexp . "\\(\\s-*\\)=")
               (modes . '(lua-mode)))))

(add-hook 'align-load-hook 'add-lua-align-list)


(add-hook 'org-mode-hook #'org-clock-auto-clockout-insinuate)


;; Tramp settings.  These are currently just for Docker while
;; developing Hatred.  It would be nice to have them within the
;; container somehow.
;; 
;; Note that customize.el also sets
;; tramp-remote-path to '(tramp-own-remote-path))
(add-to-list 'tramp-connection-properties
             (list (regexp-quote "/docker:hatred-web-1:")
                   "remote-shell" "/usr/bin/zsh"))




;; (eval-when-compile (add-to-list 'load-path (expand-file-name ".")))
(require 'helm-setup)
(require 'projectile-setup)
(require 'ruby-setup)
(require 'resize)
(provide 'pedz)
;; Old Carbon URL Processing:2 ends here
