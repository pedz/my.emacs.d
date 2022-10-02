;;; el-get-setup.el
;;
;; Code to load and get el-get running.  I no longer try to preload a
;;set of minimal packages because when moving to a new system, it is
;;painful to get the first run to start up.  My new philosophy is to
;;just add packages via el-get-list-packages once Emacs is up and
;;running and stable on the new system.
;;
(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path (expand-file-name "el-get-user/recipes" user-emacs-directory))
(el-get 'sync)

(provide 'el-get-setup)
