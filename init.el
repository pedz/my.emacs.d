;; Nifty for debugging load issues and sequences
;; This puts out a Loading message all the time
;; (setq force-load-messages t)
;; (defadvice require (before load-log activate)
;;   (message "Requiring %s" (ad-get-arg 0)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; subr.el sets this to the constant "~/.emacs.d/".  I want it to
;; track where the init file came from.  This constrains the path to
;; the init file some.
(setq user-emacs-directory (file-name-directory
			    (if user-init-file
				user-init-file
			      load-file-name)))

;; Set up minimal load-path
(dolist (dir '( "el-get/el-get" "pedz" ))
  (add-to-list 'load-path (expand-file-name dir user-emacs-directory)))

(defun pedz-magit-set-sort-column ()
  (setq tabulated-list-sort-key (cons "Name" nil)))
(eval-after-load 'magit
  (add-hook 'magit-repolist-mode-hook 'pedz-magit-set-sort-column))

;; Move the customizable values off to their own file
;; and load that file
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file)

;; Mojave seems to have changed how environment variables are set and
;; I'm tired of chasing how to do this for MacOS after each release.
;; The code below adds /usr/local/bin to exec-path and then computes
;; the PATH environment variable based upon this result.
(add-to-list 'exec-path "/usr/local/opt/gnu-sed/libexec/gnubin")
(add-to-list 'exec-path "/usr/local/opt/texinfo/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path (expand-file-name "~/bin"))
(setenv "PATH" (mapconcat 'identity exec-path ":"))

(require 'pedz)

;; el-get setup
;; Note that adding el-get/el-get is done above

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; Basic setup

;; (el-get 'sync)

;; Advanced setup

(el-get-bundle magit
  :before (global-set-key (kbd "C-x g") 'magit-status))

;; ;; Simple package names
;; (el-get-bundle yasnippet)
;; (el-get-bundle color-moccur)

;; ;; Locally defined recipe
;; (el-get-bundle yaicomplete
;;   :url "https://github.com/tarao/elisp.git"
;;   :features yaicomplete)

;; ;; With initialization code
;; (el-get-bundle zenburn-theme
;;   :url "https://raw.githubusercontent.com/bbatsov/zenburn-emacs/master/zenburn-theme.el"
;;   (load-theme 'zenburn t))
