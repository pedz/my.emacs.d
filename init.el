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
(and pedz-init-debug (message "init.el"))
(let* ((path-helper "/usr/libexec/path_helper")
       path-helper-output)
  (unless (or (string-match (getenv "USER") (getenv "PATH"))
	      (not (file-executable-p path-helper)))
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

;; Note: There are no explicit references to the variable `explicit-zsh-args'.
;; It is used implicitly by M-x shell when the interactive shell is `zsh'.
(defcustom explicit-zsh-args
  ;; Tell zsh not to use ZLE.  Shell is interactive.
  '("+Z" "-i")
  "Args passed to inferior shell by \\[shell], if the shell is zsh.
Value is a list of strings, which may be nil."
  :type '(repeat (string :tag "Argument"))
  :group 'shell)

;; Move the customizable values off to their own file and load that
;; file.  Not sure why I set custom-file but I do.
;;
(and pedz-init-debug (message "before customize"))
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file)

;; I now pull in el-get-setup.el from early-init.el due to problems
;; with dependencies and the packaging system.  My new strategy is to
;; put everything into pedz.el and let it require things.
;;
(require 'pedz)
(and pedz-init-debug (message "end init.el"))
