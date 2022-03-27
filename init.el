;; Nifty for debugging load issues and sequences
;; This puts out a Loading message all the time
;; (setq force-load-messages t)
;; (defadvice require (before load-log activate)
;;   (message "Requiring %s" (ad-get-arg 0)))

;; Set up minimal load-path.  (The use to be a longer list)
(dolist (dir '( "pedz" ))
  (add-to-list 'load-path (expand-file-name dir user-emacs-directory)))

;; Move the customizable values off to their own file
;; and load that file
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file)

(load (expand-file-name "el-get-setup.el" user-emacs-directory))

(require 'pedz)
(require 'helm-setup)                   ;Love / hate with Helm
