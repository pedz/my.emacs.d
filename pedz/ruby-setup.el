(and pedz-init-debug (message "begin ruby-setup"))
;; Setup for rbenv mode
(if (fboundp 'global-rbenv-mode)
    (progn
      (defun pedz-enable-rbenv-mode ()
        (interactive)
        (global-rbenv-mode +1)
        (rbenv-use-corresponding))
      (add-hook 'ruby-mode-hook #'pedz-enable-rbenv-mode)
      (add-hook 'enh-ruby-mode-hook #'pedz-enable-rbenv-mode)))


;; Setup for Rubocop
(if (fboundp 'rubocop-mode)
    (progn
      (defun pedz-enable-rbenv-mode ()
        (interactive)
        (rubocop-mode +1))
      (add-hook 'ruby-mode-hook #'pedz-enable-rbenv-mode)
      (add-hook 'enh-ruby-mode-hook #'pedz-enable-rbenv-mode)
      (with-eval-after-load 'rubocop
        (define-key rubocop-mode-map (kbd "s-c") 'rubocop-command-map))))



;; Setup for LSP
(if (fboundp 'lsp)
    (progn
      (defun pedz-enable-lsp-mode ()
        (interactive)
        (lsp t))
      ;; (add-hook 'ruby-mode-hook #'pedz-enable-lsp-mode)
      ;; (add-hook 'enh-ruby-mode-hook #'pedz-enable-lsp-mode)
      (with-eval-after-load 'lsp-mode
        (require 'lsp-docker-start))))


;; Put yari on s-y
(global-set-key (kbd "s-y") 'yari)


;; Try out web-mode for erb Rails templates
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))


(provide 'ruby-setup)
(and pedz-init-debug (message "end ruby-setup"))
