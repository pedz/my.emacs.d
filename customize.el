
;; Set by emacs' customizing routines -- don't change directly
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-for-comint-mode t)
 '(ansi-color-names-vector ["black" "red" "green" "gold" "blue" "magenta" "darkturquoise" "dark green"])
 '(backup-by-copying t)
 '(backup-by-copying-when-linked t)
 '(backup-directory-alist (list (cons "." (expand-file-name "backup" user-emacs-directory))))
 '(case-fold-search nil)
 '(compare-ignore-whitespace t)
 '(delete-old-versions t)
 '(display-buffer-reuse-frames t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mail-file (quote none))
 '(enable-recursive-minibuffers t)
 '(explicit-bash-args (quote ("--noediting" "--login" "-i")))
 '(feature-cucumber-command "cucumber {options} \"{feature}\"")
 '(grep-find-ignored-directories (append vc-directory-exclusion-list (list ".bundle")))
 '(inhibit-startup-screen t)
 '(js2-global-externs (quote ("jQuery" "$")))
 '(js2-include-gears-externs nil)
 '(js2-include-rhino-externs nil)
 '(mac-emulate-three-button-mouse t)
 '(mail-default-reply-to "pedz@easesoftware.com")
 '(mail-self-blind t)
 '(major-mode (quote text-mode))
 '(mmm-submode-decoration-level 2)
 '(mumamo-chunk-coloring 1 nil nil "let most of the page be uncolored and color only the sub-chunks")
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(nxhtml-skip-welcome nil nil nil "Shh!!!")
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(rails-ws:default-server-type "webrick")
 '(rspec-use-bundler-when-possible nil)
 '(rspec-use-rake-flag nil)
 '(rspec-use-rake-when-possible nil)
 '(safe-local-variable-values (quote ((encoding . utf-8) (eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t))))
 '(save-abbrevs nil)
 '(shell-popd-regexp "popd\\|P")
 '(shell-prompt-pattern ".+@.+<[0-9]+> on .*
")
 '(shell-pushd-regexp "pushd\\|p")
 '(split-width-threshold 1600)
 '(tool-bar-mode nil)
 '(user-full-name "Perry Smith")
 '(user-mail-address "pedz@easesoftware.com")
 '(vc-ignore-dir-regexp "\\`\\([\\/][\\/]\\|/\\.\\.\\./\\|/net/\\|/afs/\\)\\'")
 '(version-control t)
 '(x-select-enable-primary t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
