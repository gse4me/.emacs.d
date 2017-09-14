;; Add your custom functions here

(defcustom gse-clean-whitespace-on-save t
  "Cleanup whitespace from file before it's saved.
Will only occur if `gse-whitespace' is also enabled.
One works on certain modes where it's enabled"
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

(defun gse-p4-edit-if-necessary ()
  "Call p4 edit if a file is turned writable"
  (if (and buffer-file-name
	   (not buffer-read-only))      
      (p4-edit)
    )
  )

;;;###autoload
(defun gse-swiper-at-point (_arg)
  "Swiper with 'thing-at-point'."
  (interactive "P")
  (swiper (thing-at-point 'symbol)))



(provide 'config-functions)
