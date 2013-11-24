(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/el-get"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pedz"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;; my recipes
(setq el-get-sources
      '((:name magit
      	       :before (global-set-key (kbd "C-x C-z") 'magit-status))
	(:name cscope
	       :type github
	       :pkgname "pedz/cscope.el")))

;; my packages
(setq my-packages '(
		    auto-complete
		    feature-mode
		    rspec-mode
		    ruby-electric
		    yasnippet
		    ))

(if (executable-find "bundle")
  (add-to-list 'my-packages 'rinari))

(defun sync-packages ()
  "Synchronize packages"
  (interactive)
  (el-get 'sync '(el-get package))
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (el-get 'sync (append my-packages 
			(mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))
  (message "All packages are synchronized"))

;; Set by emacs' customizing routines -- don't change directly
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-for-comint-mode t)
 '(ansi-color-names-vector ["black" "red" "green" "gold" "blue" "magenta" "darkturquoise" "dark green"])
 '(case-fold-search nil)
 '(display-buffer-reuse-frames t)
 '(display-time-mail-file (quote none))
 '(explicit-bash-args (quote ("--noediting" "--login" "-i")))
 '(ido-enable-tramp-completion nil)
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(js2-global-externs (quote ("jQuery" "$")))
 '(js2-include-gears-externs nil)
 '(js2-include-rhino-externs nil)
 '(major-mode (quote text-mode))
 '(mmm-submode-decoration-level 2)
 '(mumamo-chunk-coloring 1 nil nil "let most of the page be uncolored and color only the sub-chunks")
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(nxhtml-skip-welcome nil nil nil "Shh!!!")
 '(rails-ws:default-server-type "webrick")
 '(rspec-use-bundler-when-possible nil)
 '(rspec-use-rake-flag nil)
 '(save-abbrevs nil)
 '(shell-prompt-pattern ".+@.+<[0-9]+> on .*
")
 '(split-width-threshold 1600)
 '(tool-bar-mode nil)
 '(user-full-name "Perry Smith")
 '(user-mail-address "pedz@easesoftware.com")
 '(vc-ignore-dir-regexp "\\`\\([\\/][\\/]\\|/\\.\\.\\./\\|/net/\\|/afs/\\)\\'")
 '(x-select-enable-primary t))

(if (require 'el-get nil t)
    (sync-packages)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (end-of-buffer)
       (eval-print-last-sexp)
       (setq el-get-verbose t)
       (sync-packages)))))

(require 'pedz)
