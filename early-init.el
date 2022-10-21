
(defun pedz/debug ( &rest args )
  "I don't know what I'm doing"
  (message (apply 'format args)))

(pedz/debug "L1")
;; Prevent package.el from running automatically before init.
(setq package-enable-at-startup nil)
(pedz/debug "L2")

;; load-path is where Emacs looks for lisp files.  I use to have
;; several directories but now it is just the user-emacs-directory and
;; the "pedz" subdirectory.
(dolist (dir '( "pedz" ))
  (add-to-list 'load-path (expand-file-name dir user-emacs-directory)))
(pedz/debug "L3")

;; chicken and egg problem: handcraft the tangling and loading of
;; org-require.el
(require 'org)
(require 'ob-tangle)
(require 'org-element)

(let ((el-path  (expand-file-name "org-require.el"  user-emacs-directory))
      (org-path (expand-file-name "org-require.org" user-emacs-directory)))
  (if (file-newer-than-file-p org-path el-path)
      (org-babel-tangle-file org-path))
  (load el-path))
(pedz/debug "L4")

;; Create init.el if necessary
(let ((load-path (list user-emacs-directory)))
  (pedz/org-create-require 'init))
(pedz/debug "L5")
