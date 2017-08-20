(use-package-with-elpa)
;; Add your custom functions here

;; (defun something
;;    (do-something))


(defcustom gse-clean-whitespace-on-save t
  "Cleanup whitespace from file before it's saved.
Will only occur if `gse-whitespace' is also enabled."
  :type 'boolean
  :group 'gse)


(defun gse-cleanup-maybe ()
  "Invoke `whitespace-cleanup' if `gse-clean-whitespace-on-save' is not nil."
  (when gse-clean-whitespace-on-save
    (whitespace-cleanup)))


(defun gse-revert-buffer()

  "revert buffer without asking for confirmation"
  (interactive "" )
  (revert-buffer t t)
  )






(provide 'config-functions)
