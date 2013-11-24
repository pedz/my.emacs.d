(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/el-get"))
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

;; Add rinari only if "bundle" is in our path or it won't install.
(if (executable-find "bundle")
  (add-to-list 'my-packages 'rinari))

;; Discovered that feature-mode (and possibly others) do not load the
;; path to their snippets if snippet feature is not already enabled.
;; So we force yasnippet to be the first package loaded.
;; (add-to-list 'my-packages 'yasnippet)

;; Move the customizable values off to their own file
;; and load that file
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

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

;; This piece of code sucks over el-get if it is not present on the
;; system and then calls sync-packages which will suck over all the
;; other packages as well.
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

;; The rest of my set up.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pedz"))

;; Lets go ahead and turn on yasnippet mode.  We have to add the
;; feature mode snippet directory since it does not do it
;; automatically
(add-to-list 'yas-snippet-dirs feature-snippet-directory)
(rspec-install-snippets)		; ditto for rspec
(yas-global-mode 1)
(require 'pedz)
