;; Nifty for debugging load issues and sequences
;; This puts out a Loading message all the time
(setq force-load-messages t)
(defadvice require (before load-log activate)
  (message "Requiring %s" (ad-get-arg 0)))

;; Add in el-get's directory and the .emacs.d directory.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/el-get"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pedz"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;; Need this very early on
(defun yas-add-to-dirs ( elt )
  "Add ELT to `yas-snippet-dirs'"
  (unless (listp yas-snippet-dirs)
    (setq yas-snippet-dirs (list yas-snippet-dirs)))
  (unless (member elt yas-snippet-dirs)
    (if (null yas-snippet-dirs)
	(setq yas-snippet-dirs (list elt))
      (push elt (cdr yas-snippet-dirs))))
  (yas-load-directory elt t)
  yas-snippet-dirs)

;;;
;;; Create needed auto execs so as things get loaded, items are
;;; cusomized as we want them.
;;;
;; Add our private recipe directory to el-get's
(eval-after-load 'el-get
  '(progn
     (message "adding to el-get's recipes")
     (add-to-list 'el-get-recipe-path "~/.emacs.d/recipes/")))

;; Lets go ahead and turn on yasnippet mode.
(eval-after-load 'yasnippet
  '(progn
     (message "yas global mode")
     (yas-global-mode 1)))

;; We want snippets in rspec mode
(eval-after-load 'rspec-mode
  '(progn
     (message "calling rspec-install-snippets")
     (yas-add-to-dirs rspec-snippets-dir)))

;; we want the snippets in feature-mode
(eval-after-load 'feature-mode
  '(progn
     (message "adding feature snippet directory")
     (require 'yasnippet)
     (yas-add-to-dirs feature-snippet-directory)))

;; Add in other package repositories
(eval-after-load 'package
  '(progn
     (message "adding package directories")
     (add-to-list 'package-archives
		  '("marmalade" . "http://marmalade-repo.org/packages/") t)
     (add-to-list 'package-archives
		  '("melpa" . "http://melpa.milkbox.net/packages/") t)))
     
;; my recipes
(setq el-get-sources
      '((:name magit
      	       :before (global-set-key (kbd "C-x C-z") 'magit-status))
	(:name cscope
	       :type github
	       :pkgname "pedz/cscope.el"
	       :post-init (add-hook 'c-initialization-hook
				    (lambda ()
				      (require 'cscope))))))

;; my packages
(setq my-packages '(
		    ;; el-get must be first
		    el-get
		    ;; package needs to be second
		    package
		    ;; load yasnippet before any other package that
		    ;; adds to the snippet dir list.
		    yasnippet
		    ;; Rest of the list
		    auto-complete
		    feature-mode
		    inf-ruby
		    rspec-mode
		    ruby-electric
		    rvm
		    yari
		    yasnippet-ruby-mode
		    ))

;; Add rinari only if "bundle" is in our path or it won't install.
(if (executable-find "bundle")
  (add-to-list 'my-packages 'rinari t))

;; Move the customizable values off to their own file
;; and load that file
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

(defun sync-packages ()
  "Synchronize packages"
  (interactive)
  (message "Starting sync")
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

;; #### put this back?
;; (add-to-list 'load-path (expand-file-name "~/yari.el"))
;; (add-to-list 'load-path (expand-file-name "~/helm"))
;; (require 'helm-config)
;; (require 'helm)
;; (require 'yari)

(require 'pedz)
