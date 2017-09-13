

(use-package ggtags
  :config
  (progn
    (dolist (hook '(verilog-mode-hook
		    ;;matlab-mode-hook
		    ;;sh-mode-hook
		    ;;cperl-mode-hook
		    c-mode-hook
		    cc-mode-hook
		    c++-mode-hook
		    ;;makefile-mode-hook
		    ;;conf-space-mode-hook
		    ))
      (add-hook hook #'ggtags-mode))

    ;; Don't consider ` (back quote) as part of `tag' when looking for a
    ;; Verilog macro definition
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
  )


(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(use-package company
  :init (progn
	  (add-to-list 'company-backends '(company-dabbrev-code company-gtags company-etags company-keywords
								company-files company-dabbrev))
	  (setq company-backends (delete 'company-clang company-backends)) ;;clang requires an expensive setup
	  )
  )

(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers))

(use-package counsel-gtags
  :diminish (counsel-gtags-mode . "CG")
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



(provide 'lang-cpp)
