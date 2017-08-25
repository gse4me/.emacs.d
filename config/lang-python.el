(use-package-with-elpa)

(use-package anaconda-mode
  :defer t
  :diminish anaconda-mode
  :init
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)))



(use-package company-anaconda
  :after anaconda-mode
  :config
  (add-to-list 'company-backends '(company-anaconda :with company-capf))
  (setq company-anaconda-case-insensitive nil)
  )

;;
(provide 'lang-python)
;;; base-python.el ends here
