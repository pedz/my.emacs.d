(defun remove-corfpga ()
    "removes the files in /corfpga/ part of the tree."
  (interactive)
  (cscope-append-flush-patterns "corfpga"))

(defun remove-sysv ()
  "Removes the files in the /sysv/ part of the tree."
  (interactive)
  (cscope-append-flush-patterns "/sysv/"))

(defun remove-v1 ()
  "Removes the files in the /adde/v1/ part of the tree."
  (interactive)
  (cscope-append-flush-patterns "pci/entcore/v1")
  (cscope-append-flush-patterns "/adde/v1/"))

(defun remove-v2 ()
  "Removes the files in the /adde/v2/ part of the tree."
  (interactive)
  (cscope-append-flush-patterns "/adde/v2/"))

(defun remove-mlxent ()
  "Removes the files in the old mlxent part of the tree."
  (interactive)
  (cscope-append-flush-patterns "src/rspc/kernext/pci/mlxent/"))

(defun remove-lncent ()
  "Removes the files in the old lncent part of the tree."
  (interactive)
  (cscope-append-flush-patterns "src/rspc/kernext/pci/lncent/"))

(defun just-lncent ()
  "Removes all but Lancer 1 entcore stuff"
  (interactive)
  (remove-v1)
  (remove-v2)
  (remove-corfpga)
  (remove-mlxent))

(defun just-v2 ()
  "Removes all but Lancer 1 entcore stuff"
  (interactive)
  (remove-v1)
  (remove-corfpga)
  (remove-mlxent)
  (remove-lncent))

(provide 'cscope-setup)
