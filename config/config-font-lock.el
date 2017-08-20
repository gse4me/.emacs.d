;; * Buffer colors

(use-package rainbow-mode
  :commands rainbow-mode
  :diminish rainbow-mode
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
    (add-hook 'css-mode-hook 'rainbow-mode)
    (add-hook 'web-mode-hook 'rainbow-mode))
  )

(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :init (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package hl-todo
  :commands hl-todo-mode
  :init (add-hook 'emacs-lisp-mode-hook #'hl-todo-mode))

(use-package highlight-numbers
  :commands highlight-numbers-mode
  :init (add-hook 'emacs-lisp-mode-hook #'highlight-numbers-mode))

(provide 'config-font-lock)
