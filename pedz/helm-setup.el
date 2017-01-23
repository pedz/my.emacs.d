(eval-when-compile
  (add-to-list 'load-path (concat (file-name-directory byte-compile-current-file)
				  "../el-get/helm")))
(require 'helm)
(require 'helm-config)

(helm-mode 1)
(provide 'helm-setup)
