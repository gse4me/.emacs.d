(use-package smart-mode-line
  :init
  (progn
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'dark)
    (sml/setup)
    (setq sml/name-width 35)
    (column-number-mode)))


(provide 'config-modeline-sml)
