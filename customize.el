
;; Set by emacs' customizing routines -- don't change directly
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-default-directory-list
   (delq nil
	 (mapcar
	  (lambda
	    (x)
	    (and
	     (file-executable-p x)
	     x))
	  Info-default-directory-list)))
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode scss-mode less-css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode web-mode ts-mode sclang-mode verilog-mode qml-mode apples-mode)))
 '(ansi-color-for-comint-mode t)
 '(ansi-color-names-vector
   ["black" "red" "green" "gold" "blue" "magenta" "darkturquoise" "dark green"])
 '(backup-by-copying t)
 '(backup-by-copying-when-linked t)
 '(backup-directory-alist
   (list
    (cons "."
	  (expand-file-name "backup" user-emacs-directory))))
 '(case-fold-search nil)
 '(delete-old-versions t)
 '(display-buffer-reuse-frames t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mail-file (quote none))
 '(enable-recursive-minibuffers t)
 '(eval-expression-print-length nil)
 '(eval-expression-print-level nil)
 '(explicit-bash-args (quote ("--noediting" "--login" "-i")))
 '(feature-cucumber-command "cucumber {options} \"{feature}\"")
 '(grep-find-ignored-directories (append vc-directory-exclusion-list (list ".bundle")))
 '(inhibit-startup-screen t)
 '(initial-frame-alist
   (cond
    ;; For Mac's with an LG UltraFine Display above the build in MBP
    ;; display.  Some key equations:
    ;;
    ;; (/ (- (display-pixel-width) (* (frame-char-width) (+ (frame-width) 5))) 2)
    ;; (/ (display-pixel-height) (frame-char-height))
    ;;
    ;; When the displays are stacked, the height appears to be the
    ;; total height of the two displays.
    ;;
    ;; The condition is for the two displays (stacked) to be mirrored
    ;; like I do at home or not like I do at work.
    ;;
    ((and (or (= (display-pixel-height) 2490)
	      (= (display-pixel-height) 1440))
    	  (= (display-pixel-width) 2560))
     (quote
      ((top . 23)
       (left . 835)
       (width . 132)
       (height . 95))))
    ((and
      (=
       (display-pixel-height)
       1050)
      (=
       (display-pixel-width)
       1680))
     (quote
      ((top . 23)
       (left . 360)
       (width . 132)
       (height . 70))))))
 '(js2-global-externs (quote ("jQuery" "$")))
 '(js2-include-gears-externs nil)
 '(js2-include-rhino-externs nil)
 '(mac-emulate-three-button-mouse t)
 '(magit-repolist-columns
   (quote
    (("Name" 42 magit-repolist-column-ident nil)
     ("Branch" 25 magit-repolist-column-branch nil)
     ("D" 1 magit-repolist-column-dirty
      ((:help-echo "uNtracked Unstaged Staged")))
     ("B<R" 3 magit-repolist-column-unpulled-from-pushremote
      ((:right-align t)
       (:help-echo "Remote changes not in branch")))
     ("B>R" 3 magit-repolist-column-unpushed-to-pushremote
      ((:right-align t)
       (:help-echo "Local changes not in remote")))
     ("B<U" 3 magit-repolist-column-unpulled-from-upstream
      ((:right-align t)
       (:help-echo "Upstream changes not in branch")))
     ("B>U" 3 magit-repolist-column-unpushed-to-upstream
      ((:right-align t)
       (:help-echo "Local changes not in upstream")))
     ("Link" 10 magit-repolist-column-url
      ((:right-align t)
       (:help-echo "Link to repo")))
     )))
 '(magit-repository-directories (quote (("/Users/pedz/git/TNC" . 1))))
 '(mail-default-reply-to "pedz@easesoftware.com")
 '(mail-self-blind t)
 '(major-mode (quote text-mode))
 '(mmm-submode-decoration-level 2)
 '(mumamo-chunk-coloring 1 nil nil "let most of the page be uncolored and color only the sub-chunks")
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(nxhtml-skip-welcome nil nil nil "Shh!!!")
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(rails-ws:default-server-type "webrick")
 '(rspec-use-bundler-when-possible nil)
 '(rspec-use-rake-flag nil)
 '(rspec-use-rake-when-possible nil)
 '(safe-local-variable-values
   (quote
    ((encoding . utf-8)
     (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
	   (add-hook
	    (quote write-contents-functions)
	    (lambda nil
	      (delete-trailing-whitespace)
	      nil))
	   (require
	    (quote whitespace))
	   "Sometimes the mode needs to be toggled off and on."
	   (whitespace-mode 0)
	   (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t))))
 '(save-abbrevs nil)
 '(select-enable-primary t)
 '(shell-popd-regexp "popd\\|P")
 '(shell-prompt-pattern ".+@.+<[0-9]+> on .*
")
 '(shell-pushd-regexp "pushd\\|p")
 '(split-width-threshold 1600)
 '(tool-bar-mode nil)
 '(user-full-name "Perry Smith")
 '(user-mail-address "pedz@easesoftware.com")
 '(vc-ignore-dir-regexp "\\`\\([\\/][\\/]\\|/\\.\\.\\./\\|/net/\\|/afs/\\)\\'")
 '(version-control t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
