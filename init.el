;; Nifty for debugging load issues and sequences
;; This puts out a Loading message all the time
;; (setq force-load-messages t)
;; (defadvice require (before load-log activate)
;;   (message "Requiring %s" (ad-get-arg 0)))

;;
;; First, we set up PATH.  We also set up MANPATH since it uses the
;; same code.
;;
;; If emacs is launched via Finder on macOS, it doesn't have much of a
;; PATH and MANPATH is usually not set at all.  If "pedz" is already
;; in PATH, then we assume that Emacs was NOT launch from the Finder
;; and we don't alter PATH or MANPATH
;;
;; This uses Apple's path_helper which is this week's method of
;; setting up the PATH and MANPATH.  We then prepend ~/bin to PATH
;;
(unless (string-match "pedz" (getenv "PATH"))
  (let* ((path-helper "/usr/libexec/path_helper")
         path-helper-output)
    (setenv "PATH" "")                  ; For consistency, zap PATH back to an empty string
    (setenv "MANPATH" "")               ; ditto for MANPATH
    (setq path-helper-output (shell-command-to-string (concat path-helper " -c")))
    (string-match "setenv \\([A-Z]+\\) \"\\([^\"]+\\)\";\nsetenv \\([A-Z]+\\) \"\\([^\"]+\\)\";\n"
                  path-helper-output)
    (setenv (match-string 1 path-helper-output) (match-string 2 path-helper-output))
    (setenv (match-string 3 path-helper-output) (match-string 4 path-helper-output))
    (setenv "PATH" (concat (expand-file-name "~/bin") ":" (getenv "PATH")))))

;; exec-path starts with a list of directories which could include
;; directories not in PATH.  A specific example are the directories
;; that contain executables within the Emacs.app folder on macOS.
;;
;; This code takes each directory in PATH and adds it to the exec-path
;; list.  The order will be munged but so far that hasn't bit me.
;;
(dolist (dir (split-string (getenv "PATH") ":"))
  (add-to-list 'exec-path dir))

;; load-path is where Emacs looks for lisp files.  I use to have
;; several directories but now it is just the starting emacs directory
;; and the "pedz" subdirectory.  el-get will add what it needs if /
;; when it is configured.
;;
(dolist (dir '( "pedz" ))
  (add-to-list 'load-path (expand-file-name dir user-emacs-directory)))

;; Move the customizable values off to their own file and load that
;; file.  Not sure why I set custom-file but I do.
;;
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file)

;; Now we finally load up the lisp files starting with the el-get
;; setup.  This tends to change often.  And finishing up with
;; helm-setup before I ofen get frustrated and remove it completely.
;;
(require 'el-get-setup)
(require 'pedz)
(require 'helm-setup)                   ;Love / hate with Helm
