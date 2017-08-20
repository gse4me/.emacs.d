;; Add your custom functions here

;; (defun something
;;    (do-something))





(defun gse-revert-buffer()
  "revert buffer without asking for confirmation"
  (interactive "" )
  (revert-buffer t t)
  )









(provide 'config-functions)
