(use-package-with-elpa)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(use-package ggtags )


(defun use-rtags (&optional useFileManager)
  (and (rtags-executable-find "rc")
       (cond ;;((not (gtags-get-rootpath)) t)
             ((and (not (eq major-mode 'c++-mode))
                   (not (eq major-mode 'c-mode))) (rtags-has-filemanager))
             (useFileManager (rtags-has-filemanager))
             (t (rtags-is-indexed)))))


(defun rtags-eldoc-function ()
  (let ((summary (rtags-get-summary-text)))
    (and summary
	 (fontify-string
	  (replace-regexp-in-string
	   "{[^}]*$" ""
	   (mapconcat
	    (lambda (str) (if (= 0 (length str)) "//" (string-trim str)))
	    (split-string summary "\r?\n")
	    " "))
	  major-mode))))



(defun fontify-string (str mode)
  "Return STR fontified according to MODE."
  (with-temp-buffer
    (insert str)
    (delay-mode-hooks (funcall mode))
    (font-lock-default-function mode)
    (font-lock-default-fontify-region
     (point-min) (point-max) nil)
    (buffer-string)))


(defun rtags-eldoc-mode ()
  (if (use-rtags t)
      (progn
	(interactive)
	(setq-local eldoc-documentation-function #'rtags-eldoc-function)
	(eldoc-mode 1))))





(use-package rtags
  :defer t
  :bind
  ( [S-mouse-1] . rtags-find-symbol-at-point )
  ( [S-down-mouse-1] . ignore)
  ( [S-mouse-3] . rtags-find-references-at-point )
  ( [S-down-mouse-3] . ignore )
  :init
  (add-hook 'c-mode-hook 'rtags-enable-standard-keybindings)
  (add-hook 'c++-mode-hook 'rtags-enable-standard-keybindings)
  (add-hook 'objc-mode-hook 'rtags-enable-standard-keybindings)
  :config
  (progn
    (setq rtags-path "/proj/mk_verif_user/users/vsandule/_tools/rtags/build/bin/")
    ;; Start rtags upon entering a C/C++ file
    (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c-mode-hook 'rtags-eldoc-mode)
    (add-hook 'c++-mode-hook 'rtags-eldoc-mode)
    (rtags-enable-standard-keybindings)
    (setq rtags-display-result-backend 'ivy)
    ;; (setq rtags-autostart-diagnostics t)
    ;; (rtags-diagnostics)
    (setq rtags-completions-enabled t)
    (setq rtags-imenu-syntax-highlighting t)
    ;;(setq rtags-tooltips-enabled t)
    )
  )

(use-package ivy-rtags
  :after rtags
  )

(use-package company-rtags
  :after rtags
  :config
  (add-to-list 'company-backends '(company-rtags))
  )

(use-package company-c-headers
  :after rtags
  :config
  (add-to-list 'company-backends 'company-c-headers)
  )

(use-package cc-mode
  :defer t
  )



(use-package modern-cpp-font-lock
  :after cc-mode
  :config (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode))





;;;;fallback to gtags if file was not indexed by rtags ;;;

;; (defun tags-find-symbol-at-point (&optional prefix)
;;   (interactive "P")
;;   (if (and (not (rtags-find-symbol-at-point prefix)) rtags-last-request-not-indexed)
;;       (gtags-find-tag)))
;; (defun tags-find-references-at-point (&optional prefix)
;;   (interactive "P")
;;   (if (and (not (rtags-find-references-at-point prefix)) rtags-last-request-not-indexed)
;;       (gtags-find-rtag)))
;; (defun tags-find-symbol ()
;;   (interactive)
;;   (call-interactively (if (use-rtags) 'rtags-find-symbol 'gtags-find-symbol)))
;; (defun tags-find-references ()
;;   (interactive)
;;   (call-interactively (if (use-rtags) 'rtags-find-references 'gtags-find-rtag)))
;; (defun tags-find-file ()
;;   (interactive)
;;   (call-interactively (if (use-rtags t) 'rtags-find-file 'gtags-find-file)))
;; (defun tags-imenu ()
;;   (interactive)
;;   (call-interactively (if (use-rtags t) 'rtags-imenu 'idomenu)))



;; (define-key global-map (kbd "M-.") (function tags-find-symbol-at-point))
;; (define-key global-map (kbd "M-,") (function tags-find-references-at-point))
;; (define-key global-map (kbd "M-;") (function tags-find-file))
;; (define-key global-map (kbd "C-.") (function tags-find-symbol))
;; (define-key global-map (kbd "C-,") (function tags-find-references))
;; (define-key global-map (kbd "C-<") (function rtags-find-virtuals-at-point))
;; (define-key global-map (kbd "M-i") (function tags-imenu))



;; (use-package cc-mode
;;   :defer t
;;   :config
;;   (progn
;;     (define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
;;     (define-key c-mode-base-map (kbd "M-,") (function tags-find-references-at-point))
;;     (define-key c-mode-base-map (kbd "M-;") (function tags-find-file))
;;     (define-key c-mode-base-map (kbd "C-.") (function tags-find-symbol))
;;     (define-key c-mode-base-map (kbd "C-,") (function tags-find-references))
;;     (define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
;;     (define-key c-mode-base-map (kbd "M-i") (function tags-imenu))
;;     )
;;   )








(provide 'lang-cpp-rtags)
