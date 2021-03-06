
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(use-package which-func                 ; Current function name
  :bind
  ([f4] . which-function-mode)
  :config
  (setq
   which-func-unknown "⊥"               ; The default is really boring…
   which-func-format
   `((:propertize (" ➤ " which-func-current)
                  local-map ,which-func-keymap
                  face which-func
                  mouse-face mode-line-highlight
                  help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end"))))

;; (use-package dumb-jump
;;   :bind (("M-g o" . dumb-jump-go-other-window)
;;          ("M-g j" . dumb-jump-go)
;;          ("M-g i" . dumb-jump-go-prompt)
;;          ("M-g x" . dumb-jump-go-prefer-external)
;;          ("M-g z" . dumb-jump-go-prefer-external-other-window))
;;   :config
;;   (setq dumb-jump-selector 'ivy
;; 	dumb-jump-ag-cmd "/tool/pandora64/.package/the_silver_searcher-0.24.1/bin/ag"
;; 	)
;;   ) 


(use-package ggtags
  :commands (ggtags-mode)
  :config
  (add-to-list 'company-backends 'company-gtags)
  (defun ggtags-tag-at-point ()
    (pcase (funcall ggtags-bounds-of-tag-function)
      (`(,beg . ,end)
       (if (eq ?` (string-to-char (buffer-substring beg end)))
	   ;; If `(buffer-substring beg end)' returns "`uvm_info" (for example),
	   ;; discard the ` and return just "uvm_info"
	   (buffer-substring (1+ beg) end)
	 ;; else return the whole `(buffer-substring beg end)'
	 (buffer-substring beg end)))))
  )

(use-package counsel-gtags
  :diminish (counsel-gtags-mode . "CG")
  :after ggtags
  :config
  (progn
    (add-hook 'c-mode-hook 'counsel-gtags-mode)
    (add-hook 'c++-mode-hook 'counsel-gtags-mode)
    ;; (with-eval-after-load 'counsel-gtags
    ;;   (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
    ;;   (define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
    ;;   (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
    ;;   (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward))
    )

  )

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
    (setq rtags-path my-rtags-path)
    ;; Start rtags upon entering a C/C++ file
    (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c-mode-hook 'rtags-eldoc-mode)
    (add-hook 'c++-mode-hook 'rtags-eldoc-mode)
    (rtags-enable-standard-keybindings)
    (setq rtags-display-result-backend 'ivy)
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
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
  (add-to-list 'company-backends '( :separate company-rtags company-dabbrev-code company-keywords))
  ;;(add-to-list 'company-backends 'company-rtags)
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
