;;; package --- python configs
;;; Commentary:
;;; Contains my python configs

;;; Code:


(use-package anaconda-mode
  :ensure t
  :commands anaconda-mode
  :diminish anaconda-mode
  :init
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)))



(use-package company-anaconda
  :ensure t
  :init (add-to-list 'company-backends '(company-anaconda :with company-capf))
  )

;;
(provide 'lang-python)
;;; base-python.el ends here
