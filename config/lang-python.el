(use-package-with-elpa)

(use-package anaconda-mode
  :commands anaconda-mode
  :diminish anaconda-mode
  :init
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)))



(use-package company-anaconda
  :init (add-to-list 'company-backends '(company-anaconda :with company-capf))
  :after anaconda-mode
  )

;;
(provide 'lang-python)
;;; base-python.el ends here
