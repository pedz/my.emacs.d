(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/el-get"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;; my recipes
(setq el-get-sources
      '((:name magit
      	       :before (global-set-key (kbd "C-x C-z") 'magit-status))))

;; my packages
(setq my-packages '(auto-complete rspec-mode ruby-electric yasnippet))

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
  ;; my packages
  (setq my-packages
	(append
	 ;; list of packages we use straight from official recipes
	 '(auto-complete
	   rinari
	   rspec-mode
	   ruby-electric
	   yasnippet)
  (el-get 'sync (append my-packages 
	 (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources)))))))

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
