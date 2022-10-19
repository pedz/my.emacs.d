(and pedz-init-debug (message "begin projectile-setup"))
;; if / when projectile is loaded, these will fire.  Originally I had
;; projectile only for Ruby projects since lsm-mode was what
;; introduced me to it.  But, I see that it is far more general
;; purpose.
(with-eval-after-load 'projectile
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))
(with-eval-after-load 'projectile-rails
  (define-key projectile-rails-mode-map (kbd "s-r") 'projectile-rails-command-map))

(defun pedz-after-projectile-track-known-projects-find-file-hook ()
  "My hook that runs after projectile-track-known-projects-find-file-hook"
  ;; (message (format "pedz-after-projectile-track-known-projects-find-file-hook: %S" projectile-project-type))
  )
(advice-add 'projectile-track-known-projects-find-file-hook :after #'pedz-after-projectile-track-known-projects-find-file-hook)

(projectile-mode +1)
;; (projectile-rails-mode +1)
(helm-projectile-on)

(provide 'projectile-setup)
(and pedz-init-debug (message "end projectile-setup"))
