;; [[file:org-require.org::*Org Require][Org Require:1]]
(defun pedz/org-create-require ( sym )
  "Given SYM, searches `load-path' until a file with a '.org'
suffix or a '.el' suffix is found.

If a file with a '.el' suffix is found first (with no matching
'.org' file), then the function returns having done no work.

If a file with a '.org' suffix is found then the file with the
'.el' suffix will be created if it does not already exist or if
it is older than the file with the '.org' suffix.

In both cases, the '.el' file is byte compiled into a '.elc' file if
the '.elc' file does not exist or is older than the '.el' file.  This
may be a mistake..."
  (catch 'found
    (dolist (path load-path)
      (let* ((basename (symbol-name sym))
	     (org-path (expand-file-name (concat basename ".org") path))
	     (el-path (expand-file-name (concat basename ".el") path))
	     (elc-path (expand-file-name (concat basename ".elc") path)))
	(cond
	 ((file-exists-p org-path)
	  (if (file-newer-than-file-p org-path el-path)
	      (progn
		(message "Tangle %s" org-path)
		(org-babel-tangle-file org-path el-path)))
	  (if (file-newer-than-file-p el-path elc-path)
	      (progn
		(message "Compile %s" el-path)
		(byte-compile-file el-path)))
	  (throw 'found t))
	 ((file-exists-p el-path)
	  (if (file-newer-than-file-p el-path elc-path)
	      (progn
		(message "Compile %s" el-path)
		(byte-compile-file el-path)))
	  (throw 'found t)))))))

(defun pedz/org-require (sym)
  "Call `pedz/org-create-require' and then `require' the SYM.
  Note that if a file with '.el' suffix is found first by
  `pedz/org-create-require', then this will simply require SYM."
  (pedz/org-create-require sym)
  (message "Loading %S" sym)
  (require sym))
;; Org Require:1 ends here
