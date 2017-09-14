
(use-package anzu
  :init (global-anzu-mode)
  :diminish anzu-mode
  )

(use-package imenu-anywhere
  :defer t
  )

(use-package link-hint
  :defer t
  )

(use-package goto-last-change
  :commands goto-last-change
  :defer t
  )

(use-package swiper
  :defer t
  :config
  (advice-add 'swiper :after #'recenter-top-bottom))


(provide 'config-search)
