(defvar pedz-init-debug nil
  "Set to t to trace initial loading of my init files")
(and pedz-init-debug (message "early-init.el"))
;; load-path is where Emacs looks for lisp files.  I use to have
;; several directories but now it is just the starting emacs directory
;; and the "pedz" subdirectory.  el-get will add what it needs if /
;; when it is configured.
;;
(dolist (dir '( "pedz" ))
  (add-to-list 'load-path (expand-file-name dir user-emacs-directory)))

(require 'el-get-setup)
(and pedz-init-debug (message "end early-init.el"))
