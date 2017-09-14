
(use-package winum
  :init
  (setq winum-keymap
  	(let ((map (make-sparse-keymap)))
  	  (define-key map (kbd "C-`") 'winum-select-window-by-number)
  	  (define-key map (kbd "C-²") 'winum-select-window-by-number)
  	  (define-key map (kbd "M-0") 'winum-select-window-0-or-10)
  	  (define-key map (kbd "M-1") 'winum-select-window-1)
  	  (define-key map (kbd "M-2") 'winum-select-window-2)
  	  (define-key map (kbd "M-3") 'winum-select-window-3)
  	  (define-key map (kbd "M-4") 'winum-select-window-4)
  	  (define-key map (kbd "M-5") 'winum-select-window-5)
  	  (define-key map (kbd "M-6") 'winum-select-window-6)
  	  (define-key map (kbd "M-7") 'winum-select-window-7)
  	  (define-key map (kbd "M-8") 'winum-select-window-8)
  	  map))
  :config
  (progn
    (set-face-attribute 'winum-face nil :weight 'bold)
    (setq window-numbering-scope            'global
	  winum-reverse-frame-list          nil
	  winum-auto-assign-0-to-minibuffer t
	  winum-auto-setup-mode-line        t
	  winum-mode-line-position          1
	  winum-ignored-buffers             '(" *which-key*"))

    (winum-mode))
  )




(use-package spaceline-config-vlad :ensure spaceline
  ;;:defer 0.1
  :init
  (progn
    (setq-default
     mode-line-format '("%e" (:eval (spaceline-ml-main)))
     powerline-default-separator 'wave
     powerline-height 20
     powerline-scale 2
     spaceline-highlight-face-func 'spaceline-highlight-face-modified
     ))
  :config
  (progn
    (spaceline-spacemacs-theme)
    )
  )


(provide 'config-modeline-spaceline)
