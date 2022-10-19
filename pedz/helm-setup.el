
(and pedz-init-debug (message "begin helm-setup"))
;; From Tuhdo's Tutorial http://tuhdo.github.io/helm-intro.html with
;; somee changes -- see comments

;; (if (require 'helm nil t)
;;     (progn
;;       (require 'helm-config)

;;       ;; Removed the last two lines below because I just customized
;;       ;; `helm-command-prefix-key' so it is set before helm is loaded.
;;       ;;
;;       ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;;       ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;;       ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;;       ;; (global-set-key (kbd "C-c h") 'helm-command-prefix)
;;       ;; (global-unset-key (kbd "C-x c"))

;;       ;; my mod... he had C-z and I changed it to C-j ... essentially swapping C-i (tab) and C-j
;;       (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;;       (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;;       (define-key helm-map (kbd "C-j")  'helm-select-action) ; list actions using C-j

;;       (when (executable-find "curl")
;;         (setq helm-google-suggest-use-curl-p t))

;;       (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;             helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;;             helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;;             helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;             helm-ff-file-name-history-use-recentf t
;;             helm-echo-input-in-header-line t)

;;       (defun spacemacs//helm-hide-minibuffer-maybe ()
;;         "Hide minibuffer in Helm session if we use the header line as input field."
;;         (when (with-helm-buffer helm-echo-input-in-header-line)
;;           (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
;;             (overlay-put ov 'window (selected-window))
;;             (overlay-put ov 'face
;;                          (let ((bg-color (face-background 'default nil)))
;;                            `(:background ,bg-color :foreground ,bg-color)))
;;             (setq-local cursor-type nil))))


;;       (add-hook 'helm-minibuffer-set-up-hook
;;                 'spacemacs//helm-hide-minibuffer-maybe)

;;       (setq helm-autoresize-max-height 0)
;;       (setq helm-autoresize-min-height 20)
;;       (helm-autoresize-mode 1)

;;       (helm-mode 1)

;;       ;; Additions added during the tutorial
;;       (global-set-key (kbd "M-x") 'helm-M-x)
;;       (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;       (global-set-key (kbd "C-x b") 'helm-mini)
;;       (global-set-key (kbd "C-x C-f") 'helm-find-files)

;;       ;; Additions via FAQ because I guess the key bindings changed recently
;;       (define-key helm-map (kbd "<left>") 'helm-previous-source)
;;       (define-key helm-map (kbd "<right>") 'helm-next-source)


;;       ;; What I use to have...
;;       ;;
;;       ;; (eval-when 'compile
;;       ;;   (add-to-list 'load-path (concat (file-name-directory byte-compile-current-file)
;;       ;; 				  "../el-get/helm")))
;;       ;; (require 'helm)
;;       ;; (require 'helm-config)

;;       ;; (helm-mode 0)
;;       ))


;; April 2, 2022 -- starting over from scratch with helm with the help
;; of the disucssion board on github

(if (require 'helm nil t)
    (progn
      (require 'helm-config)
      (global-set-key (kbd "M-x") 'helm-M-x)
      (global-set-key (kbd "M-y") 'helm-show-kill-ring)
      (global-set-key (kbd "C-x b") 'helm-mini)
      (global-set-key (kbd "C-x C-f") 'helm-find-files)
      ))
    
(provide 'helm-setup)
(and pedz-init-debug (message "end helm-setup"))
